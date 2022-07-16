var admin = require("firebase-admin");
const path = require('path')

// Fetch the service account key JSON file contents
var serviceAccount = require(path.join(__dirname, "./malikkurosaki1985-firebase-adminsdk-gdzr0-61efee2462.json"));

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://malikkurosaki1985.firebaseio.com"
});

// As an admin, the app has access to read and write all data, regardless of Security Rules
var db = admin.database();
var ref = db.ref();
ref.once("value", function (snapshot) {
    console.log(snapshot.val());
});