import * as yup from 'yup'

import { Router } from 'express'

export const detectionRouter = Router()

const detectionSchema = yup.object({
  sensorId: yup.string().required(),
})

detectionRouter.post('/detection', async (req, res, next) => {
  try {
    // TODO: fix

    const { sensorId } = await detectionSchema.validate(req.body)

    console.info(`sensor id: ${sensorId}`)

    res.status(200).json({})
  } catch (error) {
    next(error)
  }
})
