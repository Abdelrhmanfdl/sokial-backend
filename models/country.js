module.exports = (sequelize, DataTypes) => {
  const Country = sequelize.define(
    "country",
    {
      code: {
        type: "char(2)",
        primaryKey: true,
        allowNull: false,
      },
      name: {
        type: "varchar(30)",
        allowNull: false,
      },
      phone: {
        type: "varchar(5)",
        allowNull: false,
      },
    },
    { freezeTableName: true, timestamps: false, underscored: true }
  );
  return Country;
};
