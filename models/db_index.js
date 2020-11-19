const { Sequelize, DataTypes } = require("sequelize");
const dbConfig = require("../config/db.config");
const sequelize = new Sequelize(
  dbConfig.db_name,
  dbConfig.db_username,
  dbConfig.db_password,
  {
    dialect: "mysql",
    host: dbConfig.db_host,
    port: dbConfig.db_port,
    pool: {
      max: 5,
      min: 0,
      acquire: 30000,
      idle: 10000,
    },
  }
);

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;
db.userModel = require("./user")(sequelize, DataTypes);

module.exports = db;
