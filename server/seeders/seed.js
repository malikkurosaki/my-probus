const { SeedClient } = require("./seed_client");
const { SeedDepartement } = require("./seed_departement");
const { SeedIssuePriorit } = require("./seed_issue_priority");
const { SeedIssueType } = require("./seed_issue_type");
const { SeedPosition } = require("./seed_position");
const { SeedProduct } = require("./seed_product");
const { SeedRole } = require("./seed_role");
const { SeedUser } = require("./seed_user");


; (async () => {
    await SeedRole();
    await SeedUser()
    await SeedPosition()
    await SeedDepartement()
    await SeedIssueType()
    await SeedProduct()
    await SeedClient()
    await SeedIssuePriorit()
})();