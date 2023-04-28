const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();


const fetchLineup = require("./fetch_lineup");
const notifications = require("./notifications_iOS");


module.exports = {
  ...fetchLineup,
  ...notifications
};
