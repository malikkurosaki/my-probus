const expressAsyncHandler = require("express-async-handler");
const multer = require("multer");
const uuid = require("uuid");
const fs = require("fs");
const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const path = require("path");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    if (!fs.existsSync("./uploads/")) {
      fs.mkdirSync("./uploads/");
    }
    cb(null, "./uploads/");
  },
  filename: function (req, file, cb) {
    cb(null, uuid.v4() + file.originalname);
  },
});

const imageMulter = multer({ storage: storage }).array("image");
const imageMulterSingle = multer({ storage: storage }).single("image");

const uploadImage = expressAsyncHandler(async (req, res) => {
  res.status(200).json({
    message: "Upload success",
    data: req.files.map((file) => {
      return {
        name: file.filename,
      };
    }),
  });
});

const uploadSingleImage = expressAsyncHandler(async (req, res) => {
  let img = await prisma.images.create({
    data: {
      name: req.file.filename,
    },
  });

  res.status(200).json({
    message: "Upload success",
    data: {
      name: req.file.filename,
      id: img.id,
    },
  });
});

const imageDelete = expressAsyncHandler(async (req, res) => {
  if (fs.existsSync(path.join(__dirname + "./../uploads/" + req.params.name))) {
    fs.unlinkSync(path.join(__dirname + "./../uploads/" + req.params.name));

    res.status(201).json({
      message: "Delete image success",
      success: true,
      name: req.params.name,
    });
  } else {
    res.status(200).json({
      message: "Delete image failed",
      success: false,
    });
  }
});

const V2Image = {
  uploadImage,
  imageMulter,
  imageDelete,
  uploadSingleImage,
  imageMulterSingle,
};

module.exports = V2Image;
