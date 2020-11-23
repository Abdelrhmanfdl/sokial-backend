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
db.DataTypes = DataTypes;

db.userModel = require("./user")(sequelize, DataTypes);
db.friendshipRequestModel = require("./friendshipRequest")(
  sequelize,
  DataTypes
);
db.friendModel = require("./friend")(sequelize, DataTypes);

db.friendshipRequestModel.belongsTo(db.userModel, { as: "sender" });
db.friendshipRequestModel.belongsTo(db.userModel, {
  as: "receiver",
});

db.friendModel.belongsTo(db.userModel, { as: "user1" });
db.friendModel.belongsTo(db.userModel, { as: "user2" });

module.exports = db;
