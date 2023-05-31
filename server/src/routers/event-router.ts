import * as firebaseMessaging from 'firebase-admin/messaging'
import * as yup from 'yup'

import { EventModel, SensorModel, UserModel } from '../services/sequelize'

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
        message: `Sensor with the identifier <${identifier}> not found.`,
      })

      return
    }

    await EventModel.create({
      sensorId: sensor?.id,
    })

    const userId = sensor.userId

    const user = await UserModel.findOne({ where: { id: userId } })

    if (user === null) {
      res.status(400).json({
        message: `User with the id <${userId}> not found.`,
      })

      return
    }

    const fcmToken = user?.fcmToken

    if (fcmToken === null) {
      res.status(400).json({
        message: `User <${userId}> does not have an fcm token.`,
      })

      return
    }

    const messaging = firebaseMessaging.getMessaging()

    const notification = {
      title: 'Movimentação detectada',
      body: `O sensor ${sensor.identifier} detectou que seu bebê pode estar tentando sair do berço.`,
    }

    await messaging.send({
      token: fcmToken,
      notification,
      webpush: { notification },
    })

    res.status(200).json({})
  } catch (error) {
    next(error)
  }
})
