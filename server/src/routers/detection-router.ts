import * as yup from 'yup'

import { Router } from 'express'

export const detectionRouter = Router()

const detectionSchema = yup.object({
  sensorId: yup.string().required(),
})

detectionRouter.post('/detection', async (req, res, next) => {
  try {
    const { sensorId } = await detectionSchema.validate(req.body)

    console.info(`sensor id: ${sensorId}`)

    res.status(200).send()
  } catch (error) {
    next(error)
  }
})
