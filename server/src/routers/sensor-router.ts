import * as yup from 'yup'

import { Router } from 'express'

export const sensorRouter = Router()

// TODO: fix, endpoints do sensor

// const detectionSchema = yup.object({
//   sensorId: yup.string().required(),
// })

// sensorRouter.post('/detection', async (req, res, next) => {
//   try {
//     const { sensorId } = await detectionSchema.validate(req.body)

//     console.info(`sensor id: ${sensorId}`)

//     res.status(200).json({})
//   } catch (error) {
//     next(error)
//   }
// })
