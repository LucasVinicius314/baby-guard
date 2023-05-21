import { Model, Optional } from 'sequelize'
import { SequelizeBaseFieldKeys, SequelizeBaseFields } from './sequelize'

export type UserAttributes = {
  email: string
  fcmToken: string
  password: string
  username: string
} & SequelizeBaseFields

export type UserCreationAttributes = Optional<
  UserAttributes,
  SequelizeBaseFieldKeys | 'fcmToken'
>

export type UserInstance = Model<UserAttributes, UserCreationAttributes> &
  UserAttributes
