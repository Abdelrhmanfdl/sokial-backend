module.exports = (sequelize, DataTypes) => {
  const friendshipRequest = sequelize.define(
    "friendship_request",
    {
      sender_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        allowNull: false,
      },
      receiver_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        allowNull: false,
      },
      timestamp: {
        type: "DATETIME",
        allowNull: false,
      },
    },
    { freezeTableName: true, timestamps: false, underscored: true }
  );
  return friendshipRequest;
};
