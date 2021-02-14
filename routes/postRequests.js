const { db_port } = require("../config/db.config");
const { commentModel, sequelize, Sequelize } = require("../models/db_index");
const post = require("../models/post");

const router = require("express").Router(),
  db = require("../models/db_index"),
  { extractToken, assertAuthenticated, handleInvalidToken } = require("./auth");

router.post(
  "/post",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    // User post handler
    // This request is not for group posts, i will create a separate handler for it.
    /* 
        I assume that if a page made the request, its token payload contains a flag for it
        and the id is for the page not user.    
    */
    /*
    TODO :: Images FULL handling A-Z
   */

    try {
      if (req.tokenData.isPage) {
        next();
        return;
      }
      const myId = req.tokenData.id;
      const postType = "U";
      const { content, privacy, timestamp } = req.body;

      console.log(content, timestamp);

      db.postModel
        .create({
          content,
          privacy,
          timestamp,
          post_type: postType,
          author_user_id: myId,
        })
        .then((newPost) => {
          res.status(200).send({ valid: true });
        })
        .catch((err) => {
          res.status(400).send({ valid: false, message: err.message });
        });
    } catch (err) {
      res
        .status(err.statusCode || 500)
        .send({ valid: false, message: err.message });
    }
  },
  (req, res) => {
    // Page post handler

    try {
      const pageId = req.tokenData.id;
      const postType = "P";
      const { content, timestamp } = req.body;

      db.postModel
        .create({
          content,
          timestamp,
          post_type: postType,
          author_page_id: pageId,
        })
        .then((newPost) => {
          res.status(200).send({ valid: true });
        })
        .catch((err) => {
          res.status(400).send({ valid: false, message: err.message });
        });
    } catch (err) {
      res
        .status(err.statusCode || 500)
        .send({ valid: false, message: err.message });
    }
  },
  handleInvalidToken
);

router.delete(
  "/post/:post_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    // User post handler
    try {
      if (req.tokenData.isPage) {
        next();
        return;
      }
      const myId = req.tokenData.id,
        postId = req.params.post_id;

      db.postModel
        .destroy({
          where: {
            [db.Sequelize.Op.and]: [
              { id: postId },
              { author_user_id: myId },
              { post_type: "U" },
            ],
          },
        })
        .then((result) => {
          if (result == 0) {
            const err = new Error("Invalid parameter");
            err.statusCode = 400;
            throw err;
          } else {
            res.status(200).send({ valid: true });
          }
        })
        .catch((err) => {
          res
            .status(err.statusCode || 500)
            .send({ valid: false, message: err.message });
        });
    } catch (err) {
      res
        .status(err.statusCode || 500)
        .send({ valid: false, message: err.message });
    }
  },
  (req, res) => {
    // Page post handler
    try {
      const pageId = req.tokenData.id,
        postId = req.params.post_id;

      db.postModel
        .destroy({
          where: {
            [db.Sequelize.Op.and]: [
              { id: postId },
              { author_user_id: pageId },
              { post_type: "P" },
            ],
          },
        })
        .then((result) => {
          if (result == 0) {
            const err = new Error("Invalid parameter");
            err.statusCode = 400;
            throw err;
          } else {
            res.status(200).send({ valid: true });
          }
        })
        .catch((err) => {
          res
            .status(err.statusCode || 500)
            .send({ valid: false, message: err.message });
        });
    } catch (err) {
      res
        .status(err.statusCode || 500)
        .send({ valid: false, message: err.message });
    }
  },
  handleInvalidToken
);

// Get posts of a user by id
router.get(
  "/get-posts/:user_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    try {
      if (req.tokenData.isPage) {
        next();
        return;
      }

      const myId = req.tokenData.id;
      const userId = req.params.user_id;

      db.postModel
        .findAll({
          attributes: [
            "id",
            "content",
            "privacy",
            "timestamp",
            "author_user_id",
            "reactions_counter",
            "comments_counter",
          ],

          include: {
            model: db.reactionModel,
            required: false,
            attributes: ["reaction_type"],
            where: [
              {
                author_user_id: myId,
              },
            ],
          },

          where: {
            [db.Sequelize.Op.and]: [
              { author_user_id: userId },
              { post_type: "U" },
            ],
          },
          order: [["timestamp", "DESC"]],
          offset: Number(req.query.esc),
          limit: Number(req.query.limit),
        })
        .then((posts) => {
          res.status(200).send({ valid: true, posts: posts });
        });
    } catch (err) {
      res
        .status(err.statusCode || 500)
        .send({ valid: false, message: err.message });
    }
  }
);

router.put(
  "/post/:post_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    // User post handler

    try {
      if (req.tokenData.isPage) {
        next();
        return;
      }
      const myId = req.tokenData.id,
        postId = req.params.post_id;

      const { newContent, newPrivacy } = req.body;

      db.postModel
        .findOne({
          where: {
            [db.Sequelize.Op.and]: [
              { id: postId },
              { author_user_id: myId },
              { post_type: "U" },
            ],
          },
        })
        .then((foundPost) => {
          if (foundPost === null) {
            const err = new Error("Invalid parameter");
            err.statusCode = 400;
            throw err;
          } else {
            foundPost.content = newContent;
            foundPost.privacy = newPrivacy;
            return foundPost.save();
          }
        })
        .then((result) => {
          if (result === null) {
            const err = new Error("Failed");
            err.statusCode = 500;
            throw err;
          } else {
            res.status(200).send({ valid: true });
          }
        })
        .catch((err) => {
          res
            .status(err.statusCode || 500)
            .send({ valid: false, message: err.message });
        });
    } catch (err) {
      res
        .status(err.statusCode || 500)
        .send({ valid: false, message: err.message });
    }
  },
  (req, res) => {
    // Page post handler

    try {
      const pageId = req.tokenData.id,
        postId = req.params.post_id;

      const { newContent, newPrivacy } = req.body;

      db.postModel
        .findOne({
          where: {
            [db.Sequelize.Op.and]: [
              { id: postId },
              { author_user_id: pageId },
              { post_type: "P" },
            ],
          },
        })
        .then((foundPost) => {
          if (foundPost === null) {
            const err = new Error("Invalid parameter");
            err.statusCode = 400;
            throw err;
          } else {
            foundPost.content = newContent;
            foundPost.privacy = newPrivacy;
            return foundPost.save();
          }
        })
        .then((result) => {
          if (result === null) {
            const err = new Error("Failed");
            err.statusCode = 500;
            throw err;
          } else {
            res.status(200).send({ valid: true });
          }
        })
        .catch((err) => {
          res
            .status(err.statusCode || 500)
            .send({ valid: false, message: err.message });
        });
    } catch (err) {
      res
        .status(err.statusCode || 500)
        .send({ valid: false, message: err.message });
    }
  },
  handleInvalidToken
);

router.post(
  "/post/comment/:post_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    // Handle both cases : author and page authors
    /*
    TODO :: Assert that the user who comment is authorized to make that comment.
            ==> This means that this user can't comment on a post that has a privacy 
                that prevents this user from commenting. 
                (e.g. "Only me" post that user can't see) 
    */
    try {
      const myId = req.tokenData.id,
        postId = req.params.post_id;

      const { content, timestamp } = req.body;
      const commentToAdd = {
        post_id: postId,
        content: content,
        timestamp: timestamp,
      };
      if (req.tokenData.isPage)
        (commentToAdd.author_page_id = myId), (commentToAdd.author_type = "P");
      else
        (commentToAdd.author_user_id = myId), (commentToAdd.author_type = "U");

      db.commentModel
        .create(commentToAdd)
        .then((comment) => {
          if (comment === null) {
            const err = new Error("Failed");
            err.statusCode = 500;
            throw err;
          } else {
            res.status(200).send({ valid: true });
          }
        })
        .catch((err) => {
          res
            .status(err.statusCode || 400)
            .send({ valid: false, message: err.message });
        });
    } catch (err) {
      res
        .status(err.statusCode || 500)
        .send({ valid: false, message: err.message });
    }
  },
  handleInvalidToken
);

/*--------------------------------------------------------------------------------------------- */

router.get(
  "/get-comments/:post_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    try {
      if (req.tokenData.isPage) {
        next();
        return;
      }

      const postId = req.params.post_id;

      db.commentModel
        .findAll({
          attributes: ["id", "post_id", "content", "timestamp"],

          include: {
            model: db.userModel,
            as: "author_user",
            attributes: ["first_name", "last_name", "id"],
            required: true,
          },

          where: { post_id: postId },
          order: [["timestamp", "DESC"]],
          offset: Number(req.query.esc),
          limit: Number(req.query.limit),
        })
        .then((comments) => {
          res.status(200).send({ valid: true, comments: comments });
        })
        .catch((err) => {
          res.status(400).send({ valid: false, message: err.message });
        });
    } catch (err) {
      res
        .status(err.statusCode || 500)
        .send({ valid: false, message: err.message });
    }
  }
);

//=========================================================================================

router.delete(
  "/comment/:comment_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    // Handle both cases : author and page authors

    try {
      const myId = req.tokenData.id,
        commentId = req.params.comment_id;

      const commentToFind = { id: commentId };
      if (req.tokenData.isPage) commentToFind.author_page_id = myId;
      else commentToFind.author_user_id = myId;

      db.commentModel
        .destroy({
          where: commentToFind,
        })
        .then((result) => {
          if (result === 0) {
            const err = new Error("Invalid parameter");
            err.statusCode = 400;
            throw err;
          } else {
            res.status(200).send({ valid: true });
          }
        })
        .catch((err) => {
          res
            .status(err.statusCode || 500)
            .send({ valid: false, message: err.message });
        });
    } catch (err) {
      res
        .status(err.statusCode || 500)
        .send({ valid: false, message: err.message });
    }
  },
  handleInvalidToken
);

// update comment
router.put(
  "/comment/:comment_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    // Handle both cases : author and page authors
    /*
      TODO :: a separate table to save old comment versions (all updates) and handle it.
    */
    try {
      const myId = req.tokenData.id,
        commentId = req.params.comment_id;

      const commentToFind = { id: commentId },
        { newContent } = req.body;
      if (req.tokenData.isPage) commentToFind.author_page_id = myId;
      else commentToFind.author_user_id = myId;

      db.commentModel
        .findOne({
          where: commentToFind,
        })
        .then((foundComment) => {
          if (foundComment === null) {
            const err = new Error("Invalid parameter");
            err.statusCode = 400;
            throw err;
          } else {
            foundComment.content = newContent;
            return foundComment.save();
          }
        })
        .then((result) => {
          if (result === 0) {
            const err = new Error("Invalid parameter");
            err.statusCode = 400;
            throw err;
          } else {
            res.status(200).send({ valid: true });
          }
        })
        .catch((err) => {
          res
            .status(err.statusCode || 500)
            .send({ valid: false, message: err.message });
        });
    } catch (err) {
      res
        .status(err.statusCode || 500)
        .send({ valid: false, message: err.message });
    }
  },
  handleInvalidToken
);

// ------------------------------------------------------------------------------------------------

router.post(
  "/post/react/:post_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    try {
      if (req.tokenData.isPage) {
        next();
        return;
      }

      const myId = req.tokenData.id;
      const postId = req.params.post_id;
      const reactionType = req.query.reaction_type;
      const reactantType = "U";

      const D = new Date();

      db.reactionModel
        .findOne({
          attributes: ["id"],
          where: {
            [db.Sequelize.Op.and]: [
              { post_id: postId },
              { reactant_type: reactantType },
              { author_user_id: myId },
            ],
          },
        })
        .then((result) => {
          if (!result) {
            // User has no reaction for this post, then create a reaction
            db.reactionModel
              .create({
                post_id: postId,
                author_user_id: myId,
                reactant_type: reactantType,
                reaction_type: reactionType,
                timestamp: `${D.getFullYear()}-${
                  D.getMonth() + 1
                }-${D.getDate()} ${D.getHours()}-${D.getMinutes()}-${D.getSeconds()}`,
              })
              .then(() => {
                res.status(200).send({ valid: true }).end();
              });
          } else {
            // User already has reacted for this post, then create a reaction
            result.destroy().then(() => {
              res.status(200).send({ valid: true }).end();
            });
          }
        })
        .catch((err) => {
          res
            .status(err.statusCode || 500)
            .send({ valid: false, message: err.message });
        });
    } catch (err) {
      res
        .status(err.statusCode || 500)
        .send({ valid: false, message: err.message });
    }
  },
  handleInvalidToken
);

module.exports = { router };
