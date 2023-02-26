import * as yup from 'yup'

import { Op } from 'sequelize'
import { Router } from 'express'
import { UserModel } from '../services/sequelize'
import { sha256 } from '../utils/crypto'
import { signJwt } from '../utils/jwt'

export const authRouter = Router()

const loginSchema = yup.object({
  email: yup.string().email().required(),
  password: yup.string().min(4).required(),
})

authRouter.post('/login', async (req, res, next) => {
  try {
    const { email, password } = await loginSchema.validate(req.body)

    const passwordHash = sha256(password)

    const userInstance = await UserModel.findOne({
      where: {
        [Op.and]: {
          email: email,
          password: passwordHash,
        },
      },
    })

    if (userInstance == null) {
      res.status(401).json({})

      return
    }

    const signedJwt = signJwt(userInstance.dataValues)

    res.status(200).json({
      token: signedJwt,
    })
  } catch (error) {
    next(error)
  }
})

const registerSchema = yup.object({
  email: yup.string().email().required(),
  password: yup.string().min(4).required(),
  username: yup.string().min(3).required(),
})

authRouter.post('/register', async (req, res, next) => {
  try {
    const { email, password, username } = await registerSchema.validate(
      req.body
    )

    const passwordHash = sha256(password)

    const userInstance = await UserModel.create({
      email: email,
      password: passwordHash,
      username: username,
    })

    const signedJwt = signJwt(userInstance.dataValues)

    res.status(201).json({
      token: signedJwt,
    })
  } catch (error) {
    next(error)
  }
})
