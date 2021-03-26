const router = require("express").Router(),
  db = require("../models/db_index"),
  bcrypt = require("bcrypt"),
  jwt = require("jsonwebtoken");

router.get("/about-auth", (req, res) => {
  // Main component use it to check whether Auth or not, and get userData if auth

  try {
    const token = req.cookies.token;
    if (!token) {
      res.status(200).send({ auth: false });
    } else {
      const data = jwt.verify(token, process.env.token_secret_key);
      db.userModel
        .findOne({
          attributes: ["id", "first_name", "last_name", "profile_image_path"],
          where: {
            id: data.id,
          },
        })
        .then((foundUser) => {
          if (foundUser)
            res
              .status(200)
              .send({ auth: true, userData: foundUser.dataValues });
          else throw new Error("Can't find user");
        })
        .catch((err) => {
          res
            .clearCookie("token")
            .status(200)
            .send({ auth: false, message: err.message });
        });
    }
  } catch (e) {
    res.status(200).send({ auth: false });
  }
});

const extractToken = (req, res, next) => {
  try {
    const token = req.cookies.token;
    if (token) {
      const data = jwt.verify(token, process.env.token_secret_key);
      req.tokenData = data;
    }
    next();
  } catch (err) {
    next(err);
  }
};

const assertUnauthenticated = (req, res, next) => {
  // assert no token found, as the process is for unauthenticated people(e.g. login, signup)

  if (req.tokenData === undefined) {
    next();
  } else {
    res.status(401).send({
      valid: false,
      message: "Token is found (Already authenticated).",
    });
  }
};

const assertAuthenticated = (req, res, next) => {
  // assert valid token exists
  if (req.tokenData) {
    next();
  } else {
    res.status(403).send({
      valid: false,
      message: "Unauthenticated user",
    });
  }
};

const handleInvalidToken = (err, req, res, next) => {
  res.status(403).send({ valid: false, message: err.message });
  next();
};

router.post(
  "/signup",
  extractToken,
  assertUnauthenticated,
  (req, res, next) => {
    const {
      email,
      password,
      fName,
      lName,
      country,
      city,
      gender,
      dob,
    } = req.body;

    try {
      const lowerCaseEmail = email.toLowerCase();

      db.userModel
        .findOne({
          attributes: ["id"],
          where: {
            email: lowerCaseEmail,
          },
        })
        .then((foundUser) => {
          if (foundUser !== null) {
            return Promise.reject({ message: "Email already exists." });
          } else {
            return bcrypt.genSalt(parseInt(process.env.salt_rounds));
          }
        })
        .then((salt) => {
          return bcrypt.hash(password, salt);
        })
        .then((hashedPassword) => {
          return db.userModel.create({
            email: lowerCaseEmail,
            password: hashedPassword,
            first_name: fName,
            last_name: lName,
            country,
            city,
            gender,
            dob,
          });
        })
        .then((newUser) => {
          const token = jwt.sign(
            {
              id: newUser.id,
              firstName: fName,
              lastName: lName,
            },
            process.env.token_secret_key
          );
          res.cookie("token", token, {
            httpOnly: true,
            maxAge: parseInt(process.env.token_max_age),
          });
          res.status(200).send({
            valid: true,
            userData: {
              id: newUser.id,
              firstName: fName,
              lastName: lName,
            },
          });
        })
        .catch((err) => {
          // I need a better method to differ app issues VS DB issues (to handle status codes)
          if (
            err.name === "SequelizeConnectionError" ||
            err.name === "SequelizeConnectionRefusedError"
          )
            res.status(500).send({
              valid: false,
              message: err.message,
            });
          else
            res.status(403).send({
              valid: false,
              message: err.message,
            });
        });
    } catch (err) {
      return res.status(500).send({ valid: false, message: err.message });
    }
  }
);

router.post(
  "/login",
  extractToken,
  assertUnauthenticated,
  (req, res, next) => {
    const { email, password } = req.body;
    const lowerCaseEmail = email.toLowerCase();
    try {
      db.userModel
        .findOne({
          attributes: [
            "id",
            "first_name",
            "last_name",
            "password",
            "profile_image_path",
          ],
          where: {
            email: lowerCaseEmail,
          },
        })
        .then((foundUser) => {
          if (foundUser === null) {
            return Promise.reject({ message: "Invalid email or password" });
          } else {
            return Promise.all([
              foundUser,
              bcrypt.compare(password, foundUser.password),
            ]);
          }
        })
        .then((promiseArr) => {
          let foundUser = promiseArr[0],
            isSamePassword = promiseArr[1];
          if (isSamePassword) {
            const token = jwt.sign(
              {
                id: foundUser.id,
                firstName: foundUser.first_name,
                lastName: foundUser.last_name,
              },
              process.env.token_secret_key
            );
            res.cookie("token", token, {
              httpOnly: true,
              maxAge: process.env.token_max_age,
            });
            res.status(200).send({
              valid: true,
              userData: {
                id: foundUser.id,
                firstName: foundUser.first_name,
                lastName: foundUser.last_name,
                profile_image_path: foundUser.profile_image_path,
              },
            });
          } else {
            return Promise.reject({ message: "Invalid email or password" });
          }
        })
        .catch((err) => {
          if (
            err.name === "SequelizeConnectionError" ||
            err.name === "SequelizeConnectionRefusedError"
          )
            res.status(500).send({
              valid: false,
              serverErrorMessage: err.message,
            });
          else
            res.status(403).send({
              valid: false,
              message: err.message,
            });
        });
    } catch (err) {
      return res.status(500).send({ valid: false });
    }
  },
  handleInvalidToken
);

router.post("/logout", extractToken, assertAuthenticated, (req, res, next) => {
  res.clearCookie("token").status(200).end();
});

module.exports = {
  router,
  extractToken,
  assertAuthenticated,
  assertUnauthenticated,
  handleInvalidToken,
};
