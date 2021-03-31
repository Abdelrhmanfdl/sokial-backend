module.exports = (sequelize, DataTypes) => {
  const Post = sequelize.define(
    "post",
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
      group_id: {
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
      comments_counter: {
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 0,
      },
      privacy: {
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 4,
      },
      post_type: {
        type: DataTypes.CHAR(1),
        allowNull: false,
      },
    },
    { freezeTableName: true, timestamps: false, underscored: true }
  );
  return Post;
};
