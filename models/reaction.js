module.exports = (sequelize, DataTypes) => {
  const Reaction = sequelize.define(
    "reaction",
    {
      author_user_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        allowNull: false,
      },
      post_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        allowNull: false,
      },
      timestamp: {
        type: "DATETIME",
        allowNull: false,
      },
      reaction_type: {
        type: "VARCHAR(1)", // Like='1'  | ...
        allowNull: false,
      },
    },
    { freezeTableName: true, timestamps: false, underscored: true }
  );
  return Reaction;
};
