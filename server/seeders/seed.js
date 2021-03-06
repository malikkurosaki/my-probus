const { SeedAdmin } = require("./seed_admin");
const { SeedClient } = require("./seed_client");
const { SeedCs } = require("./seed_cs");
const { SeedDepartement, SeedDepartementClear } = require("./seed_departement");
const { SeedIssue } = require("./seed_issue");
const { SeedIssuePriorit } = require("./seed_issue_priority");
const { SeedIssueStatus } = require("./seed_issue_status");
const { SeedIssueType } = require("./seed_issue_type");
const { SeedLeader } = require("./seed_leader");
const { SeedModerator } = require("./seed_moderator");
const { SeedPosition } = require("./seed_position");
const { SeedProduct } = require("./seed_product");
const { SeedRole } = require("./seed_role");
const { SeedSuperAdmin } = require("./seed_super_admin");
const { SeedTrainer } = require("./seed_trainer");
const { SeedUser } = require("./seed_user");

(async () => {
  await SeedRole();
  await SeedUser();
  await SeedPosition();
  await SeedDepartement();
  await SeedIssueType();
  await SeedProduct();
  await SeedClient();
  await SeedIssuePriorit();
  await SeedIssueStatus();
  await SeedLeader();
  await SeedTrainer();
  await SeedCs();
  await SeedModerator();
  await SeedSuperAdmin();
  await SeedAdmin();
})();
