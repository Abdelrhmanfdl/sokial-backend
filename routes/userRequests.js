const { compareSync } = require("bcrypt");
const { sequelize } = require("../models/db_index");
const { QueryTypes } = require("sequelize");

const router = require("express").Router(),
  { extractToken, handleInvalidToken, assertAuthenticated } = require("./auth"),
  db = require("../models/db_index");

// Send friendship request
router.post(
  "/friendship-request/:receiver_id",
  extractToken,
  assertAuthenticated,
  (req, res, next) => {
    /*
       TODO :: Handle the case of sending requests in the same time between two users  
    */

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
            const D = new Date();
            return db.friendshipRequestModel.create({
              sender_id: senderId,
              receiver_id: receiverId,
              timestamp: `${D.getFullYear()}-${
                D.getMonth() + 1
              }-${D.getDate()} ${D.getHours()}-${D.getMinutes()}-${D.getSeconds()} `,
            });
          }
        })
        .then((newRecord) => {
          console.log(">>>>>>>>", newRecord);
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

// Reject friendship request OR Unsend friendship request
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
          order: [["timestamp", "DESC"]],
          offset: Number(req.query.esc),
          limit: Number(req.query.limit),
        })
        .then((records) => {
          // TODO :: get and return photo
          const data = [];
          const theyAre = asReceiver ? "sender" : "receiver";
          records.forEach((record) => {
            data.push({
              id: record[theyAre].id,
              firstName: record[theyAre].first_name,
              lastName: record[theyAre].last_name,
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

// Accept friendship request
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
    // ** TODO ::  (i think it's not a best practice to make 2 request 'me=user1', 'me=user2') **
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

// Unfriend
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
      const myId = req.tokenData.id;
      const userId = Number(req.params.user_id);
      const getFriendshipRel = req.query.getFriendshipRel == "true";

      let queryPromise;

      // If the profile is "mine" (for the client) then no need to make 2 joins in the query
      // TODO :: Search about the effect of such a join with one got entry, and update based on that
      if (getFriendshipRel === false) {
        queryPromise = db.userModel.findAll({
          attributes: ["id", "first_name", "last_name"],
          where: {
            id: userId,
          },
        });
      } else {
        /* 
          - Currently i preferred to make a one big query over 3 small queries.
          - This query is responsible for three tasks
            1- get the basic data of the profile
            2- get the friendship entry between 'me' and the profile (2 null's if not friends)
            3- get the friendship request entry between 'me' and the profile (2 null's if no friendship req)
               + from entry i got, i can know if this profile is a sender or receiver by the id's position.
        */

        queryPromise = sequelize.query(
          `SELECT id, first_name,last_name, friend.user1_id AS fr1_id, friend.user2_id AS fr2_id
            , fr_rel.sender_id AS sender_id, fr_rel.receiver_id AS receiver_id
            FROM user AS prof LEFT OUTER JOIN friend
            ON (prof.id = friend.user1_id and friend.user2_id = ${myId})
            or(prof.id = friend.user2_id and friend.user1_id = ${myId}) 
 
            LEFT OUTER JOIN friendship_request AS fr_rel
            ON (prof.id = fr_rel.sender_id and receiver_id = ${myId})
            or(prof.id = fr_rel.receiver_id and sender_id = ${myId})
 
            WHERE prof.id = ${userId}`,

          { type: QueryTypes.SELECT }
        );
      }

      queryPromise
        .then((entry) => {
          entry = entry[0];
          console.log(entry);
          if (!entry) throw new Error("No user found");

          let resBody = {
            valid: true,
            userData: {
              id: entry.id,
              firstName: entry.first_name,
              lastName: entry.last_name,
            },
            friendshipRel: null,
          };

          if (myId !== userId) {
            resBody.friendshipRel = {
              areFriends: entry.fr1_id !== null,
              friendshipReqSenderId: entry.sender_id,
              friendshipReqReceiverId: entry.receiver_id,
            };
          }
          res.status(200).send(resBody);
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
