import { Router } from 'express'

export const detectionRouter = Router()

detectionRouter.post('/detection', (req, res) => {
  res.status(200).send()
})
