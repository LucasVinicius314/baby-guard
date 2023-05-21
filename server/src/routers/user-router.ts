import * as yup from 'yup'

import { Router } from 'express'
import { UserModel } from '../services/sequelize'

export const userRouter = Router()

// Get.

userRouter.get('/', async (req, res, next) => {
  try {
    const userId = req.user.id

    const user = await UserModel.findOne({ where: { id: userId } })

    res.status(200).json({
      user,
    })
  } catch (error) {
    console.log(error)

    next(error)
  }
})

// Update Firebase Cloud Messaging notification token.

const updateNotificationTokenSchema = yup.object({
  fcmToken: yup.string(),
})

userRouter.put('/notification-token', async (req, res, next) => {
  try {
    const { fcmToken } = await updateNotificationTokenSchema.validate(req.body)

    const userId = req.user.id

    const user = await UserModel.findOne({ where: { id: userId } })

    await user?.update({ fcmToken })

    res.status(200).json({})
  } catch (error) {
    console.log(error)

    next(error)
  }
})
