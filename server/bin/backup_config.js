const {
  PrismaClient
} = require("@prisma/client");
const prisma = new PrismaClient();
const fs = require("fs");
const csvtojson = require("csvtojson");
const path = require("path");
const _ = require("lodash");

async function UpdateauthToken() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/authToken.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.authToken.create({
      data: itm
    });
  }

  console.log("authToken success");
}

async function Updateclients() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/clients.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.clients.create({
      data: itm
    });
  }

  console.log("clients success");
}

async function UpdatecontactPersons() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/contactPersons.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.contactPersons.create({
      data: itm
    });
  }

  console.log("contactPersons success");
}

async function Updatedepartements() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/departements.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.departements.create({
      data: itm
    });
  }

  console.log("departements success");
}

async function Updatediscussion() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/discussion.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.discussion.create({
      data: itm
    });
  }

  console.log("discussion success");
}

async function Updateimages() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/images.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.images.create({
      data: itm
    });
  }

  console.log("images success");
}

async function UpdateissueHistories() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/issueHistories.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.issueHistories.create({
      data: itm
    });
  }

  console.log("issueHistories success");
}

async function UpdateissuePriorities() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/issuePriorities.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);
  let ky = Object.keys(data[0]);

  console.log(ky);
  for (let itm of data) {

    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if(ky != "id"){
        
      }
    }

    // for (let i of ky) {
    //   if (_.isEmpty(itm[i])) {
    //     itm[i] = undefined;
    //   }

    //   console.log(itm[i], _.isNumber(itm[i]));

    //   if (_.isNumber(itm[i])) {
    //     itm[i] = Number(itm[i]);
    //   }
    // }

    // console.log(itm);
    // await prisma.issuePriorities.create({
    //   data: itm
    // });
  }

  console.log("issuePriorities success");
}

async function UpdateissueStatuses() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/issueStatuses.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.issueStatuses.create({
      data: itm
    });
  }

  console.log("issueStatuses success");
}

async function UpdateissueTypes() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/issueTypes.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.issueTypes.create({
      data: itm
    });
  }

  console.log("issueTypes success");
}

async function Updateissues() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/issues.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.issues.create({
      data: itm
    });
  }

  console.log("issues success");
}

async function Updatepositions() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/positions.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.positions.create({
      data: itm
    });
  }

  console.log("positions success");
}

async function Updateproducts() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/products.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.products.create({
      data: itm
    });
  }

  console.log("products success");
}

async function Updateprofiles() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/profiles.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.profiles.create({
      data: itm
    });
  }

  console.log("profiles success");
}

async function Updateroles() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/roles.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.roles.create({
      data: itm
    });
  }

  console.log("roles success");
}

async function Updateusers() {
  let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/users.csv")).toString();
  const data = await csvtojson().fromString(dataTarget);

  for (let itm of data) {
    let ky = Object.keys(itm);
    for (let i of ky) {
      if (_.isEmpty(itm[i])) {
        itm[i] = undefined;
      }

      if (_.isNumber(itm[i])) {
        itm[i] = Number(itm[i]);
      }
    }
    await prisma.users.create({
      data: itm
    });
  }

  console.log("users success");
}

;
(async () => {
  //   await Updateroles();
  //   await Updateusers();
  //   await UpdateauthToken()
  //   await Updateclients()
  //   await UpdatecontactPersons()
  //   await Updatedepartements()
  //   await Updatediscussion()
  //   await Updateimages()
  //   await UpdateissueHistories()
  await UpdateissuePriorities()
  //   await UpdateissueStatuses()
  //   await UpdateissueTypes()
  //   await Updateissues()
  //   await Updatepositions()
  //   await Updateproducts()
  //   await Updateprofiles()

})();

;
(async () => {})();;
(async () => {})();;
(async () => {})();