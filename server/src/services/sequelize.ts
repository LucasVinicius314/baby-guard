import { DataTypes, Sequelize } from 'sequelize'

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

UserModel.prototype.toJSON = function () {
  let values = Object.assign({}, this.get())
  delete values.password

  return values
}
