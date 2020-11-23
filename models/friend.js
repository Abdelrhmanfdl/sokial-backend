module.exports = (sequelize, DataTypes) => {
  const friend = sequelize.define(
    "friend",
    {
      user1_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        allowNull: false,
      },
      user2_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        allowNull: false,
      },
    },
    { freezeTableName: true, timestamps: false, underscored: true }
  );
  return friend;
};
