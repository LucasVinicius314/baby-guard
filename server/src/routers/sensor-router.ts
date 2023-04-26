import * as yup from 'yup'

import { EventModel, SensorModel } from '../services/sequelize'

import { Router } from 'express'

export const sensorRouter = Router()

// Create.

const createSchema = yup.object({
  identifier: yup.string().required(),
})

sensorRouter.post('/', async (req, res, next) => {
  try {
    const { identifier } = await createSchema.validate(req.body)

    console.info(`sensor idendifier: ${identifier}`)

    const userId = req.user.id

    await SensorModel.create({
      identifier,
      userId,
    })

    res.status(201).json({})
  } catch (error) {
    next(error)
  }
})

// List.

sensorRouter.get('/', async (req, res, next) => {
  try {
    const userId = req.user.id

    const sensors = await SensorModel.findAll({
      where: { userId },
      order: [['createdAt', 'DESC']],
    })

    res.status(200).json({
      sensors: sensors,
    })
  } catch (error) {
    next(error)
  }
})

// Delete.

const deleteSchema = yup.object({
  sensorId: yup.number().required(),
})

sensorRouter.delete('/:sensorId', async (req, res, next) => {
  try {
    const userId = req.user.id

    const { sensorId } = await deleteSchema.validate({
      sensorId: req.params.sensorId,
    })

    const sensor = await SensorModel.destroy({
      where: { userId, id: sensorId },
    })

    if (sensor === 0) {
      res.status(404).json({
        message: `Sensor with the id <${sensorId}> not found`,
      })

      return
    }

    res.status(200).json({})
  } catch (error) {
    next(error)
  }
})

// List events.

const listEventsSchema = yup.object({
  sensorId: yup.number().required(),
})

sensorRouter.get('/:sensorId/event', async (req, res, next) => {
  try {
    const userId = req.user.id

    const { sensorId } = await listEventsSchema.validate({
      sensorId: req.params.sensorId,
    })

    const events = await EventModel.findAll({
      where: { sensorId },
      include: {
        model: SensorModel,
        where: { userId },
        attributes: [],
      },
    })

    res.status(200).json({
      events: events,
    })
  } catch (error) {
    next(error)
  }
})
