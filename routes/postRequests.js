const { db_port } = require("../config/db.config");
const { commentModel, sequelize, Sequelize } = require("../models/db_index");
const post = require("../models/post");
const fs = require("fs");
const path = require("path");
const Busboy = require("busboy");
const UUID = require("uuid");

const router = require("express").Router(),
  db = require("../models/db_index"),
  { extractToken, assertAuthenticated, handleInvalidToken } = require("./auth");

const getUpdatedPostCounters = (postId) => {
  // Return the updated number of comments and reactions for that post
  return db.postModel.findOne({
    attributes: ["reactions_counter", "comments_counter"],
    where: {
      id: postId,
    },
  });
};

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
          res.status(200).send({
            valid: true,
            postData: { ...newPost.dataValues, content: undefined },
          });
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

router.post(
  "/set-post-image/:post_id",
  extractToken,
  assertAuthenticated,
  (req, res) => {
    try {
      const postId = req.params.post_id;
      db.postModel
        .findOne({
          attributes: ["id"],
          where: {
            id: postId,
          },
        })
        .then((foundPost) => {
          if (!foundPost) {
            const err = new Error("Invalid post id parameter");
            err.status = 400;
            throw err;
          } else {
            let imageName = UUID.v4();
            const busboy = new Busboy({ headers: req.headers });
            let imgPath;

            busboy.on(
              "file",
              function (fieldname, file, filename, encoding, mimetype) {
                imageName = imageName.concat(
                  `.${mimetype.slice(mimetype.lastIndexOf("/") + 1)}`
                );
                imgPath = path.join(__dirname, "..", "uploads", `${imageName}`);
                file.pipe(fs.createWriteStream(imgPath));
              }
            );
            /*
            busboy.on(
              "field",
              (
                fieldname,
                value,
                fieldnameTruncated,
                valueTruncated,
                transferEncoding,
                mimeType
              ) => {
                console.log("\n\n\n\n", fieldname, ": ", value, "\n\n\n\n");
              }
            );
*/
            busboy.on("finish", function () {
              db.postImageModel
                .create({
                  image_path: imageName,
                  post_id: postId,
                })
                .then((entry) => {
                  res.send({ valid: true, imageData: entry });
                })
                .catch((err) => {
                  res.send({ valid: false, message: err.message });
                });
            });

            return req.pipe(busboy);
          }
        })
        .catch((err) => {
          res
            .status(err.status || 500)
            .send({ valid: false, message: err.message });
        });
    } catch (err) {
      res
        .status(err.status || 500)
        .send({ valid: false, message: err.message });
    }
  },
  handleInvalidToken
);

router.get(
  "/get-post-image/:image_path",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    try {
      const imagePath = req.params.image_path;
      const fullPath = path.join(__dirname, "..", "uploads", imagePath);

      // Async check for whether the image exists
      fs.access(fullPath, (err) => {
        if (err) {
          // If doesn't exist ==> error
          return res.status(400).send({
            valid: false,
            message: "This image doesn't exist",
          });
        } else {
          // If the image exists
          return res.sendFile(fullPath);
        }
      });
    } catch (err) {
      res
        .status(err.status || 500)
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

          include: [
            {
              model: db.postImageModel,
              required: false,
              attributes: ["id", "image_path"],
            },
            {
              model: db.reactionModel,
              required: false,
              attributes: ["reaction_type"],
              where: [
                {
                  author_user_id: myId,
                },
              ],
            },
          ],

          where: {
            [db.Sequelize.Op.and]: [
              { author_user_id: userId },
              { post_type: "U" },
              {
                timestamp: {
                  [db.Sequelize.Op.lte]: req.query.beforeDate,
                },
              },
            ],
          },
          order: [["timestamp", "DESC"]],
          offset: Number(req.query.esc),
          limit: Number(req.query.limit),
        })
        .then((posts) => {
          // [{ id, content, ...., post_images:[{id, image_path}]  }]
          res.status(200).send({ valid: true, posts: posts });
        })
        .catch((err) => {
          console.log("\n\n\n\n\n" + err.message + "\n\n\n");
          res
            .status(err.statusCode || 500)
            .send({ valid: false, message: err.message });
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
        .then((newComment) => {
          if (newComment === null) {
            const err = new Error("Failed");
            err.statusCode = 500;
            throw err;
          } else {
            res.status(200).send({
              valid: true,
              commentData: {
                id: newComment.dataValues.id,
                author_type: newComment.dataValues.author_type,
                author_user_id: newComment.dataValues.author_user_id,
                post_id: newComment.dataValues.post_id,
                reactions_counter: 0,
                timestamp: newComment.dataValues.timestamp,
              },
            });
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
            attributes: ["first_name", "last_name", "id", "profile_image_path"],
            required: true,
          },

          where: { post_id: postId },
          order: [["timestamp", "DESC"]],
          offset: Number(req.query.esc),
          limit: Number(req.query.limit),
        })
        .then((comments) => {
          // data sent : { id, post_id, content, timestamp, author_user:{id, first_name, last_name, profile_image_path} }
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

router.get(
  "/post/react/post-reactants/:post_id",
  extractToken,
  assertAuthenticated,
  (req, res) => {
    try {
      const postId = req.params.post_id;
      db.userModel
        .findAll({
          raw: true,
          attributes: [
            "id",
            ["first_name", "firstName"],
            ["last_name", "lastName"],
            ["profile_image_path", "profileImagePath"],
          ],

          include: [
            {
              as: "reactions",
              model: db.reactionModel,
              require: true,
              where: {
                post_id: postId,
                timestamp: {
                  [db.Sequelize.Op.lte]: req.query.beforeDate,
                },
              },
              attributes: ["timestamp"],
            },
          ],

          order: [["reactions", "timestamp", "DESC"]],
          offset: Number(req.query.esc),
          limit: Number(req.query.limit),
        })
        .then((results) => {
          res.status(200).send({ valid: true, reactants: results });
        })
        .catch((err) => {
          res.status(500).send({ valid: false, message: err.message });
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
  "/post/react/:post_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    try {
      const myId = req.tokenData.id;
      const postId = req.params.post_id;
      const reactionType = req.query.reaction_type;

      const D = new Date();

      db.reactionModel
        .findOne({
          attributes: ["author_user_id", "post_id"],
          where: {
            [db.Sequelize.Op.and]: [
              { post_id: postId },
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
                reaction_type: reactionType,
                timestamp: `${D.getFullYear()}-${
                  D.getMonth() + 1
                }-${D.getDate()} ${D.getHours()}-${D.getMinutes()}-${D.getSeconds()}`,
              })
              .then(() => {
                return getUpdatedPostCounters(postId);
              })
              .then((entry) => {
                console.log(entry);
                res
                  .status(200)
                  .send({ valid: true, post_counters: entry.dataValues });
              })
              .catch((err) => {
                console.log(err.message);
                throw new Error(err.message);
              });
          } else {
            // User already has reacted for this post, then create a reaction
            result
              .destroy()
              .then(() => {
                return getUpdatedPostCounters(postId);
              })
              .then((entry) => {
                res
                  .status(200)
                  .send({ valid: true, post_counters: entry.dataValues });
              })
              .catch((err) => {
                console.log(err.message);
                throw new Error(err.message);
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
