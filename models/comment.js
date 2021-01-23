module.exports = (sequelize, DataTypes) => {
  const Comment = sequelize.define(
    "comment",
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
      author_user_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
      },
      author_page_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
      },
      content: {
        type: "varchar(14000)",
        allowNull: false,
      },
      timestamp: {
        type: "DATETIME",
        allowNull: false,
      },
      reactions_counter: {
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 0,
      },
      author_type: {
        type: DataTypes.CHAR(1),
        allowNull: false,
      },
    },
    { freezeTableName: true, timestamps: false, underscored: true }
  );
  return Comment;
};
