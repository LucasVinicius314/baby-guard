import { detectionRouter } from './routers/detection-router'
import express from 'express'

const port = process.env.PORT

const app = express()

app.use((req, res, next) => {
  const now = new Date()

  console.info(`${now.toISOString()} ${req.method} ${req.url}`)

  next()
})

app.use('/api/v1', detectionRouter)

app.listen(port, () => {
  console.log(`listening on port ${port}`)
})
