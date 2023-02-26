import * as yup from 'yup'

import { Router } from 'express'
import { SensorModel } from '../services/sequelize'

export const sensorRouter = Router()

const createSchema = yup.object({
  identifier: yup.string().required(),
})

sensorRouter.post('/', async (req, res, next) => {
  try {
    const { identifier } = await createSchema.validate(req.body)

    console.info(`sensor idendifier: ${identifier}`)

    const userId = req.user.id

    await SensorModel.create({
      identifier: identifier,
      userId: userId,
    })

    res.status(200).json({})
  } catch (error) {
    next(error)
  }
})

sensorRouter.get('/', async (req, res, next) => {
  try {
    const userId = req.user.id

    const sensors = await SensorModel.findAll({ where: { userId: userId } })

    res.status(200).json({
      sensors: sensors,
    })
  } catch (error) {
    next(error)
  }
})
