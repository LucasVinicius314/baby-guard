import express, { NextFunction, Request, Response } from 'express'

import { detectionRouter } from './routers/detection-router'
import { json } from 'body-parser'

const port = process.env.PORT

const app = express()

app.use(json())

app.use((req, res, next) => {
  const now = new Date()

  console.info(`${now.toISOString()} ${req.method} ${req.url}`)
  console.info(req.body)

  next()
})

app.use('/api/v1', detectionRouter)

app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
  console.error(err.stack)

  res.status(500).send()
})

app.listen(port, () => {
  console.log(`listening on port ${port}`)
})
