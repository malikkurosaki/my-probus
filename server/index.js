const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const express = require("express");
// const app = express();
const {httpServer, app} = require('./index_https_config')
const port = 3001;
const cors = require("cors");
const { api } = require("./routers");
const { routeLogin } = require("./controllers/login");
const apiRoot = "/api/v1";
require("dotenv").config();
const jwt = require("jsonwebtoken");
const { Server } = require("socket.io");
const fs = require('fs')
// const createServer = require("https").createServer;
// const fs = require("fs");
// const httpServer = createServer(
//   {
//     key: fs.readFileSync("key.pem"),
//     cert: fs.readFileSync("cert.pem"),
//   },
//   app);

const path = require("path");
const io = new Server(httpServer, {
  allowEIO3: true,
  cors: {
    origin: true,
    credentials: true,
  },
});

const { routeDashboard } = require("./controllers/dashboard");
const { routeMaster } = require("./controllers/master");
const v2Routers = require("./v2_routers");
const V2Login = require("./v2_controller/v2_login");

// const { routeImage } = require('./controllers/image');

io.of('/notif').on("connection", (socket) => {
  socket.on("client", async (data) => {
    let notif = await prisma.notif.create({
      data,
      select: {
        id: true,
        title: true,
        content: true,
        jenis: true,
        User: {
          select: {
            id: true,
            name: true,
          },
        },
      },
    });

    socket.emit("server", notif);
  });

  socket.on("disconnect", () => {
    console.log("user disconnected");
  });
});

// const { routeImage } = require('./controllers/image');
// const fs = require('fs');
// const https = require('https');
// var selfsigned = require('selfsigned');
// var attrs = [{ name: 'makuro', value: 'google.com' }];
// var pems = selfsigned.generate(attrs, { days: 365 });

app.use(cors());

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
// app.use(express.static(path.join(__dirname, "public")));
// app.use(express.static(path.join(__dirname, "./../client/build/web")));
//app.use(express.static('assets'));
// app.get('/', (req, res) => res.send('Hello World!'));
app.get("/", (req, res) => {
  res.redirect('https://malikkurosaki.github.io/my-probus/client/build/web/');
});

app.use("/api/v2", v2Routers);
app.use("/login", V2Login);
// app.use('/images', routeImage);
app.get("/my-probus-apk", (req, res) => {
  res.sendFile(
    path.join(
      __dirname,
      "./../client/build/app/outputs/apk/release/app-arm64-v8a-release.apk"
    )
  );
});

app.get("/build-debug", (req, res) => {
  let debug = require(path.join(__dirname, "./build.json"));
  res.json(debug);
});
const cobaApi = express.Router();
cobaApi.use("/dashboard", routeDashboard);
app.use(cobaApi);

app.use("/master", routeMaster);

// dafri upload image
app.get("/image/:name", (req, res) => {
  if (fs.existsSync(__dirname + "/uploads/" + req.params.name)) {
    res.sendFile("/uploads/" + req.params.name, { root: __dirname });
  } else {
    res
      .type("image/png")
      .sendFile("./assets/images/noimage.png", { root: __dirname });
  }
});

// dari assets
app.get("/images/:name", (req, res) => {
  if (fs.existsSync(__dirname + "/assets/images/" + req.params.name)) {
    res.sendFile("/assets/images/" + req.params.name, { root: __dirname });
  } else {
    res
      .type("image/png")
      .sendFile("./assets/images/noimage.png", { root: __dirname });
  }
});

app.use(apiRoot, async (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];
  if (token == null) {
    console.log("token null", authHeader);
    return res.sendStatus(401);
  }

  // jwt.verify(token, process.env.TOKEN_API, (err, user) => {

  //     if (err) {
  //         console.log("error 403", err)
  //         return res.sendStatus(403)
  //     } else {
  //         req.userId = user.userId
  //         next()
  //     }

  // })

  const auth = await prisma.authToken.findUnique({
    where: {
      id: token,
    },
    include: {
      User: true,
    },
  });

  if (auth == null) {
    console.log("error 403", auth);
    return res.sendStatus(403);
  } else {
    req.userId = auth.User.id;
    next();
  }
});

app.use(apiRoot, api);

httpServer.listen(port, () =>
  console.log(`Example app listening on port ${port}!`)
);

