module.exports = (sequelize, DataTypes) => {
  const Reaction = sequelize.define(
    "reaction",
    {
      id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false,
      },
      author_user_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
      },
      author_page_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
      },
      post_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      timestamp: {
        type: "DATETIME",
        allowNull: false,
      },
      reactant_type: {
        type: "VARCHAR(1)", // User='U'  | Page='P'
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
