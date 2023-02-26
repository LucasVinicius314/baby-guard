import express, { NextFunction, Request, Response } from 'express'

import { ValidationError } from 'yup'
import { authRouter } from './routers/auth-router'
import { detectionRouter } from './routers/detection-router'
import { json } from 'body-parser'
import { sequelize } from './services/sequelize'

const port = process.env.PORT

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
  await configureSequelize()

  const app = express()

  app.use(json())

  app.use((req, res, next) => {
    const now = new Date()

    console.info(`${now.toISOString()} ${req.method} ${req.url}`)
    console.info(req.body)

    next()
  })

  // TODO: fix, authentication middleware

  app.use('/api/v1', detectionRouter)
  app.use('/api/v1', authRouter)

  app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    console.error(err.stack)

    if (err instanceof ValidationError) {
      res.status(400).json({
        message: err.message,
      })

      return
    }

    res.status(500).send()
  })

  app.listen(port, () => {
    console.log(`listening on port ${port}`)
  })
}

main()
