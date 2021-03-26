module.exports = (sequelize, DataTypes) => {
  return sequelize.define(
    "post_image",
    {
      id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false,
      },
      post_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      image_path: {
        type: "VARCHAR(1000)",
        allowNull: false,
      },
    },
    { freezeTableName: true, timestamps: false, underscored: true }
  );
};
