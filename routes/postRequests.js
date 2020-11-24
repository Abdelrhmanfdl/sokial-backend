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

module.exports = { router };
