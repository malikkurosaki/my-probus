const V2Client = require("./v2_controller/v2_client");
const V2Discution = require("./v2_controller/v2_discution");
const V2Image = require("./v2_controller/v2_image");
const V2Issue = require("./v2_controller/v2_issue");
const V2IssueHistory = require("./v2_controller/v2_issue_history");
const V2Module = require("./v2_controller/v2_module");
const V2Product = require("./v2_controller/v2_product");
const V2Properties = require("./v2_controller/v2_properties");
const V2Status = require("./v2_controller/v2_status");
const V2Todos = require("./v2_controller/v2_todos");
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
v2Routers.post("/update-issue-status/:id", V2Issue.updateIssueStatus);
v2Routers.get("/properties-all", V2Properties.all);
v2Routers.post("/todo-create", V2Todos.create);
v2Routers.get("/todo-get-all/:id/:date", V2Todos.findMany);
v2Routers.post("/todo-change-status", V2Todos.changeStatus);

// delete todo
v2Routers.delete("/todo-delete/:id", V2Todos.deleteTodo);

// delete issue
v2Routers.delete("/issue-delete/:id", V2Issue.deleteIssue);

// list todo
v2Routers.get("/todo-list/:date", V2Todos.listTodo);

// update todo
v2Routers.post("/todo-update", V2Todos.updateTodo);

// get issue history
v2Routers.get("/issue-history/:statusId", V2IssueHistory.getIssueHistoryByStatus);

// get issue by departement id : query
v2Routers.get("/issue-by-departement-id", V2Issue.getIssueByDepartementId);


module.exports = v2Routers;

