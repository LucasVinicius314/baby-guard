import { DataTypes, Sequelize } from 'sequelize'

import { SensorInstance } from '../typescript/sensor'
import { UserInstance } from '../typescript/user'

export const sequelize = new Sequelize(process.env.DATABASE_URL, {
  ssl: false,
  dialect: 'postgres',
})

const baseAttributes = {
  id: {
    primaryKey: true,
    type: DataTypes.INTEGER,
    autoIncrement: true,
  },
  createdAt: {
    type: DataTypes.DATE,
  },
  updatedAt: {
    type: DataTypes.DATE,
  },
}

export const UserModel = sequelize.define<UserInstance>('user', {
  ...baseAttributes,
  email: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
  password: {
    type: DataTypes.STRING(256),
    allowNull: false,
  },
  username: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
})

export const SensorModel = sequelize.define<SensorInstance>('sensor', {
  ...baseAttributes,
  alias: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  identifier: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
  userId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
})

// User -> Sensor

UserModel.hasMany(SensorModel, { foreignKey: 'userId' })
SensorModel.belongsTo(UserModel, { foreignKey: 'userId' })

UserModel.prototype.toJSON = function () {
  let values = Object.assign({}, this.get())
  delete values.password

  return values
}
