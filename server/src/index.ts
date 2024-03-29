import * as firebaseAdmin from 'firebase-admin/app'

import express, { NextFunction, Request, Response } from 'express'

import { ValidationError } from 'yup'
import { authRouter } from './routers/auth-router'
import { eventRouter } from './routers/event-router'
import { json } from 'body-parser'
import { sensorRouter } from './routers/sensor-router'
import { sequelize } from './services/sequelize'
import { userRouter } from './routers/user-router'
import { validateJwt } from './utils/jwt'

const port = process.env.PORT

const configureFirebase = () => {
  firebaseAdmin.initializeApp()
}

const configureSequelize = async () => {
  await sequelize
    .authenticate()
    .then(() => console.log('Database auth ok'))
    .catch(console.log)

  await sequelize
    .sync({ alter: true, force: false, logging: false })
    .then(() => console.log('Database sync ok'))
    .catch(console.log)
}

const main = async () => {
  configureFirebase()

  await configureSequelize()

  const app = express()

  app.use(json())

  app.use((req, res, next) => {
    const now = new Date()

    console.info(`${now.toISOString()} ${req.method} ${req.url}`)
    console.info(req.body)

    next()
  })

  app.use('/api/v1/auth', authRouter)

  app.use('/api/v1/event', eventRouter)

  app.use((req, res, next) => {
    try {
      const token = req.headers.authorization

      const user = validateJwt(token)

      req.user = user

      next()
    } catch (error) {
      res.status(401).json({})
    }
  })

  app.use('/api/v1/sensor', sensorRouter)

  app.use('/api/v1/user', userRouter)

  app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    console.error(err.stack)

    if (err instanceof ValidationError) {
      res.status(400).json({
        message: err.message,
      })

      return
    }

    res.status(500).send({
      message: err.toString(),
    })
  })

  app.listen(port, () => {
    console.log(`listening on port ${port}`)
  })
}

main()
