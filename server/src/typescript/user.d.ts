import { Model, Optional } from 'sequelize'
import { SequelizeBaseFieldKeys, SequelizeBaseFields } from './sequelize'

export type UserAttributes = {
  email: string
  password: string
  username: string
} & SequelizeBaseFields

export type UserCreationAttributes = Optional<
  UserAttributes,
  SequelizeBaseFieldKeys
>

export type UserInstance = Model<UserAttributes, UserCreationAttributes> &
  UserAttributes
