require("dotenv").config();

const express = require("express"),
  cookieParser = require("cookie-parser"),
  app = express(),
  cors = require("cors"),
  path = require("path");

app.use("/", express.static(path.join(__dirname, "..", "sokial", "build")));

PORT = process.env.PORT || 8080;

require("./models/db_index");

app.use(express.json());
app.use(cookieParser());
app.use(require("./routes/auth").router);
app.use(require("./routes/userRequests").router);
app.use(require("./routes/postRequests").router);
app.use(require("./routes/homeRequests").router);

app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "..", "sokial", "build", "index.html"));
});

app.listen(PORT, () => console.log("App is listening to port : " + PORT));
