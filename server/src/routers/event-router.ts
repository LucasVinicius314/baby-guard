import * as yup from 'yup'

import { EventModel, SensorModel } from '../services/sequelize'

import { Router } from 'express'

export const eventRouter = Router()

// Detection.

// TODO: fix, middleware de autenticação de evento

const detectionSchema = yup.object({
  identifier: yup.string().required(),
})

eventRouter.post('/detection/:identifier', async (req, res, next) => {
  try {
    const { identifier } = await detectionSchema.validate({
      identifier: req.params.identifier,
    })

    console.info(`sensor identifier: ${identifier}`)

    const sensor = await SensorModel.findOne({
      where: { identifier },
    })

    if (sensor === null) {
      res.status(400).json({
        message: `Sensor with the identifier <${identifier}> not found`,
      })

      return
    }

    await EventModel.create({
      sensorId: sensor?.id,
    })

    res.status(200).json({})
  } catch (error) {
    next(error)
  }
})
