import { Model, Optional } from 'sequelize'
import { SequelizeBaseFieldKeys, SequelizeBaseFields } from './sequelize'

export type SensorAttributes = {
  alias: string
  identifier: string
  userId: number
} & SequelizeBaseFields

export type SensorCreationAttributes = Optional<
  SensorAttributes,
  SequelizeBaseFieldKeys | 'alias'
>

export type SensorInstance = Model<SensorAttributes, SensorCreationAttributes> &
  SensorAttributes
