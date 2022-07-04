const V2Client = require("./v2_controller/v2_client");
const V2Discution = require("./v2_controller/v2_discution");
const V2Image = require("./v2_controller/v2_image");
const V2Issue = require("./v2_controller/v2_issue");
const V2Module = require("./v2_controller/v2_module");
const V2Product = require("./v2_controller/v2_product");
const V2Status = require("./v2_controller/v2_status");
const V2Type = require("./v2_controller/v2_type");
const v2Routers = require("express").Router();

// a1 do not delete this line
v2Routers.get("/client", V2Client.clientGetAll);
v2Routers.get("/products", V2Product.getAll);
v2Routers.get("/modules", V2Module.getAll);
v2Routers.post("/upload-image", V2Image.imageMulter, V2Image.uploadImage);
v2Routers.post("/upload-image-single", V2Image.imageMulterSingle, V2Image.uploadSingleImage);
v2Routers.delete("/image-delete/:name", V2Image.imageDelete);
v2Routers.get("/type", V2Type.getAll);
v2Routers.get("/issue-get-all", V2Issue.getAll);
v2Routers.post("/issue-create", V2Issue.create);
v2Routers.get("/issue-by-role", V2Issue.issueByRole)
v2Routers.get("/issue-by-status-id/:id", V2Issue.issueByStatusId);
v2Routers.get("/issue-by-id/:id", V2Issue.getIssueById);
v2Routers.get("/client-get-id-by-name/:name", V2Client.getIdByName);
v2Routers.get("/status-get-all", V2Status.getAll);
v2Routers.get("/discution-by-issue-id/:id", V2Discution.getDiscutionByIssueId);
v2Routers.post("/discution-create", V2Discution.createDiscution);
v2Routers.get("/update-issue-status/:id", V2Issue.updateIssueStatus);

module.exports = v2Routers;

