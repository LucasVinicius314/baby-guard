import { Model, Optional } from 'sequelize'
import { SequelizeBaseFieldKeys, SequelizeBaseFields } from './sequelize'

export type EventAttributes = {
  sensorId: number
} & SequelizeBaseFields

export type EventCreationAttributes = Optional<
  EventAttributes,
  SequelizeBaseFieldKeys
>

export type EventInstance = Model<EventAttributes, EventCreationAttributes> &
  EventAttributes
