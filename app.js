require("dotenv").config();

const express = require("express"),
  cookieParser = require("cookie-parser"),
  app = express(),
  PORT = process.env.PORT || 8080;

require("./models/db_index");

app.use(express.json());
app.use(cookieParser());
app.use(require("./routes/auth").router);
app.use(require("./routes/userRequests").router);

app.listen(PORT, () => console.log("App is listening to port : " + PORT));
