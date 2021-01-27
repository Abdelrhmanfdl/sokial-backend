const { compareSync } = require("bcrypt");

const router = require("express").Router(),
  { extractToken, handleInvalidToken, assertAuthenticated } = require("./auth"),
  db = require("../models/db_index");

router.post(
  "/friendship-request/:receiver_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    try {
      const senderId = req.tokenData.id;
      const receiverId = parseInt(req.params.receiver_id);

      if (senderId == receiverId) {
        const err = new Error("User can not send himself a friendship request");
        err.statusCode = 403;
        throw err;
      }
      if (receiverId === NaN) {
        const err = new Error("Invalid request parameter");
        err.statusCode = 400;
        throw err;
      }

      db.friendshipRequestModel
        .findOne({
          where: {
            [db.Sequelize.Op.or]: [
              {
                [db.Sequelize.Op.and]: [
                  { sender_id: senderId },
                  { receiver_id: receiverId },
                ],
              },
              {
                [db.Sequelize.Op.and]: [
                  { sender_id: receiverId },
                  { receiver_id: senderId },
                ],
              },
            ],
          },
        })
        .then((foundRecord) => {
          if (foundRecord !== null) {
            return Promise.reject("Friendship request already exits.");
          } else {
            return db.friendshipRequestModel.create({
              sender_id: senderId,
              receiver_id: receiverId,
            });
          }
        })
        .then((newRecord) => {
          res.status(200).send({ valid: true });
        })
        .catch((err) => {
          if (
            err.name === "SequelizeConnectionError" ||
            err.name === "SequelizeConnectionRefusedError"
          )
            res.status(500).send({
              valid: false,
            });
          else res.status(403).send({ valid: false, message: err.message });
        });
    } catch (err) {
      if (err.statusCode)
        res.status(err.statusCode).send({ valid: false, message: err.message });
      else res.status(500).send({ valid: false });
    }
  },
  handleInvalidToken
);

router.delete(
  "/friendship-request/:other_id",
  extractToken,
  assertAuthenticated,
  (req, res) => {
    try {
      const myId = req.tokenData.id,
        otherId = parseInt(req.params.other_id);

      if (myId === otherId) {
        const err = new Error("User can not send himself a friendship request");
        err.statusCode = 403;
        throw err;
      }
      if (otherId === NaN) {
        const err = new Error("Invalid request parameter");
        err.statusCode = 400;
        throw err;
      }

      db.friendshipRequestModel
        .destroy({
          where: {
            [db.Sequelize.Op.or]: [
              {
                [db.Sequelize.Op.and]: [
                  { sender_id: myId },
                  { receiver_id: otherId },
                ],
              },
              {
                [db.Sequelize.Op.and]: [
                  { sender_id: otherId },
                  { receiver_id: myId },
                ],
              },
            ],
          },
        })
        .then((result) => {
          if (result === 0) {
            const err = new Error("No friendship request exists");
            throw err;
          } else res.status(200).send({ valid: true });
        })
        .catch((err) => {
          res.status(403).send({ valid: false, message: err.message });
        });
    } catch (err) {
      if (err.statusCode === undefined) {
        res.status(500).send({ valid: false });
      } else
        res.status(err.statusCode).send({ valid: false, message: err.message });
    }
  },
  handleInvalidToken
);

router.get(
  "/friendship-request/requests",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    // respond with (id, name, photo)

    try {
      const myId = req.tokenData.id;
      const asReceiver = req.query.asreceiver.toLowerCase() == "true";

      let whereAsRecOrSen;
      if (asReceiver) whereAsRecOrSen = { receiver_id: myId };
      else whereAsRecOrSen = { sender_id: myId };

      db.friendshipRequestModel
        .findAll({
          attributes: [],
          where: whereAsRecOrSen,
          include: [
            {
              model: db.userModel,
              as: asReceiver ? "sender" : "receiver",
              required: true,
              attributes: ["id", "first_name", "last_name"],
            },
          ],
        })
        .then((records) => {
          // TODO :: get and return photo
          const data = [];
          const theyAre = asReceiver ? "sender" : "receiver";
          records.forEach((record) => {
            data.push({
              id: record[theyAre].id,
              first_name: record[theyAre].first_name,
              last_name: record[theyAre].last_name,
            });
          });
          res.status(200).send({ valid: true, data });
        })
        .catch((err) => {
          res.status(500).send({ valid: false, message: err.message });
        });
    } catch (err) {
      res.status(500).send({ valid: false, message: err.message });
    }
  },
  handleInvalidToken
);

router.post(
  "/friendship-request/accept/:other_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    // delete the request from friendship-request model Then add it to friend model

    try {
      const myId = req.tokenData.id;
      const otherId = parseInt(req.params.other_id);

      if (otherId === NaN) {
        const err = new Error("Invalid request parameter");
        err.statusCode = 400;
        throw err;
      }

      db.friendshipRequestModel
        .destroy({
          where: {
            [db.Sequelize.Op.and]: [
              { sender_id: otherId },
              { receiver_id: myId },
            ],
          },
        })
        .then((result) => {
          if (result === 0) {
            // no records are deleted
            let err = new Error("Invalid request parameter");
            err.statusCode = 400;
            throw err;
          } else {
            return db.friendModel.create({
              user1_id: myId,
              user2_id: otherId,
            });
          }
        })
        .then((friendRecord) => {
          if (friendRecord === null) {
            const err = new Error();
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

router.get(
  "/friends",
  extractToken,
  assertAuthenticated,
  (req, res) => {
    // respond with ( id , name , photo )
    // ** to be modified (i think it's not a best practice to make 2 request 'me=user1', 'me=user2') **
    try {
      const myId = req.tokenData.id;
      db.friendModel
        .findAll({
          attributes: [],
          where: {
            user1_id: myId,
          },
          include: {
            model: db.userModel,
            as: "user2",
            required: true,
            attributes: ["id", "first_name", "last_name"],
          },
        })
        .then((records) => {
          const secondQueryPromise = db.friendModel.findAll({
            attributes: [],
            where: {
              user2_id: myId,
            },
            include: {
              model: db.userModel,
              as: "user1",
              required: true,
              attributes: ["id", "first_name", "last_name"],
            },
          });

          return Promise.all([records, secondQueryPromise]);
        })
        .then((queryArr) => {
          const data = [];
          queryArr[0].forEach((record) => {
            data.push({
              id: record.user2.id,
              first_name: record.user2.first_name,
              last_name: record.user2.last_name,
            });
          });
          queryArr[1].forEach((record) => {
            data.push({
              id: record.user1.id,
              first_name: record.user1.first_name,
              last_name: record.user1.last_name,
            });
          });

          res.status(200).send({ valid: true, data });
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
  "/friends/unfriend/:other_id",
  extractToken,
  assertAuthenticated,
  (req, res) => {
    const myId = req.tokenData.id,
      otherId = req.params.other_id;

    if (myId === otherId) {
      const err = new Error("User can not send himself a friendship request");
      err.statusCode = 403;
      throw err;
    }
    if (otherId === NaN) {
      const err = new Error("Invalid request parameter");
      err.statusCode = 400;
      throw err;
    }

    db.friendModel
      .destroy({
        where: {
          [db.Sequelize.Op.or]: [
            {
              [db.Sequelize.Op.and]: [
                { user1_id: myId },
                { user2_id: otherId },
              ],
            },
            {
              [db.Sequelize.Op.and]: [
                { user1_id: otherId },
                { user2_id: myId },
              ],
            },
          ],
        },
      })
      .then((result) => {
        if (result == 0) {
          const err = new Error("Invalid request parameter");
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
  },
  handleInvalidToken
);

// Can be used when entering an profile
router.get(
  "/get-basic-user-data/:user_id",
  extractToken,
  assertAuthenticated,
  (req, res) => {
    try {
      const userId = req.params.user_id;

      db.userModel
        .findOne({
          /* TODO :: Add more attributes as useful */
          attributes: ["id", "first_name", "last_name"],
          where: {
            id: userId,
          },
        })
        .then((user) => {
          if (!user) throw new Error("No user found");
          res.status(200).send({
            valid: true,
            userData: {
              id: user.id,
              firstName: user.first_name,
              lastName: user.last_name,
            },
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
  handleInvalidToken
);

module.exports = { router };
