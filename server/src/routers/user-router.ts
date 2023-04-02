import { Router } from 'express'
import { UserModel } from '../services/sequelize'

export const userRouter = Router()

userRouter.get('/', async (req, res, next) => {
  try {
    const userId = req.user.id

    const user = await UserModel.findOne({ where: { id: userId } })

    res.status(200).json({
      user: user,
    })
  } catch (error) {
    console.log(error)

    next(error)
  }
})
