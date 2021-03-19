const router = require("express").Router(),
  { QueryTypes } = require("sequelize"),
  db = require("../models/db_index"),
  { extractToken, assertAuthenticated, handleInvalidToken } = require("./auth");

router.get(
  "/home/posts",
  extractToken,
  assertAuthenticated,
  (req, res) => {
    try {
      const myId = req.tokenData.id;
      const esc = req.query.esc;
      const limit = req.query.limit;

      // Get posts of me and of friends with author data
      db.sequelize
        .query(
          `
        SELECT distinct P.author_user_id, P.id AS post_id, 
        U.first_name, U.last_name, U.profile_photo_path, P.content, P.privacy, P.timestamp, P.post_type,  
            P.reactions_counter, P.comments_counter, Re.reaction_type AS my_reaction_type
        FROM user AS U INNER JOIN friend AS FR
        ON U.id = FR.user1_id AND FR.user2_id = ${myId}
        OR U.id = FR.user2_id AND FR.user1_id = ${myId}
        OR U.id = ${myId}
        JOIN post AS P
        ON U.id = P.author_user_id
        LEFT OUTER JOIN reaction AS Re
        ON P.id = Re.post_id AND Re.author_user_id = ${myId}
        ORDER BY P.timestamp DESC limit ${esc}, ${limit};`,
          { type: QueryTypes.SELECT }
        )
        .then((entries) => {
          console.log(entries);
          res.status(200).send({ valid: true, entries });
        })
        .catch((err) => {
          res
            .status(err.status | 500)
            .send({ valid: false, message: err.message });
        });
    } catch (err) {
      res.status(err.status | 500).send({ valid: false, message: err.message });
    }
  },
  handleInvalidToken
);

module.exports = { router };
