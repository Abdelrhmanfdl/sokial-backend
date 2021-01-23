const { commentModel } = require("../models/db_index");
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

router.post(
  "/comment/:post_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    // Handle both cases : author and page authors
    /*
    TODO :: Assert that the user who comment is authorized to make that comment.
            ==> Than means that this user can't comment on a post that has a privacy 
                that prevents this user from commenting. 
                (e.g. "Only me" post that user can't see) 
    
    TODO :: Update comment_counter of the post

    */
    try {
      const myId = req.tokenData.id,
        postId = req.params.post_id;

      db.postModel
        .findOne({
          attributes: ["id", "privacy", "comments_counter"],
          where: {
            id: postId,
          },
        })
        .then((foundPost) => {
          if (foundPost === null) {
            const err = new Error("Invalid parameter");
            err.statusCode = 400;
            throw err;
          } else {
            const { content, timestamp } = req.body;
            const commentToAdd = {
              post_id: postId,
              content: content,
              timestamp: timestamp,
            };
            if (req.tokenData.isPage)
              (commentToAdd.author_page_id = myId),
                (commentToAdd.author_type = "P");
            else
              (commentToAdd.author_user_id = myId),
                (commentToAdd.author_type = "U");
            return Promise.all([
              foundPost,
              db.commentModel.create(commentToAdd),
            ]);
          }
        })
        .then(([post, comment]) => {
          if (comment === null) {
            const err = new Error("Failed");
            err.statusCode = 500;
            throw err;
          } else {
            const beforeUpdate = post.comments_counter;
            post.comments_counter += 1;
            return Promise.all([beforeUpdate, post.save()]);
          }
        })
        .then(([beforeUpdate, post]) => {
          if (post.comments_counter === beforeUpdate) {
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
            return db.postModel.findOne({
              attributes: ["comments_counter"],
              where: { post_id: postId },
            });
          }
        })
        .then((post) => {
          if (post == null) {
            const err = new Error("Failed"); // TODO :: roll back the transaction
            err.statusCode = 500;
            throw err;
          } else {
            const beforeUpdate = post.comments_counter;
            post.comments_counter -= 1;
            return Promise.all([beforeUpdate, post.save()]);
          }
        })
        .then(([beforeUpdate, post]) => {
          if (beforeUpdate === post.comments_counter) {
            const err = new Error("Failed"); // TODO :: roll back the transaction
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

module.exports = { router };
