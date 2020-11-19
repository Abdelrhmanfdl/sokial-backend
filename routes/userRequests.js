const router = require("express").Router(),
  { extractToken, handleInvalidToken } = require("./auth"),
  db = require("../models/db_index");

router.put(
  "/friendship-request",
  extractToken,
  (req, res, next) => {
    const requesterId = req.tokenData.id;
  },
  handleInvalidToken
);

module.exports = router;
