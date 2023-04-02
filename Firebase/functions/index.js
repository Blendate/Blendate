const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const MESSAGE_TITLE = "You have a new message!";
const MESSAGE_BODY = " sent you a message";
const MATCH_TITLE = "You have a new Blend!";
const MATCH_BODY = "You Blended with ";


const MATHCES_FIELD = "matches"
const NAME_FIELD = "firstname"





// Sends a notifications to all users when a new message is posted.
exports.iosMatchNotifications = functions.firestore.document('matches/{mid}').onCreate(
  async (snapshot) => {
    console.log("New Match Triggered")
    const match = snapshot.data();
    let users = []
    users = match.users;
    let tokens = []
    console.log(`Found ${users.count} Users`)

    const fcm1 = await getFCM(users[0]);
    const fcm2 = await getFCM(users[1]);
    if (fcm1) {
      tokens.push(fcm1);
    }
    if (fcm2) {
      tokens.push(fcm2);
    }

    console.log(`Found ${tokens.count} Tokens`)
    const payload = {
      notification: {
        title: `You have a new Blend!`,
        body: 'You matched with someone!',
        // icon: snapshot.data().profilePicUrl || '/images/profile_placeholder.png',
        // click_action: `https://${process.env.GCLOUD_PROJECT}.firebaseapp.com`,
      }
    };

    if (tokens.length > 0) {
      // Send notifications to all tokens.
      const response = await admin.messaging().sendToDevice(tokens, payload);
      functions.logger.log('Notifications have been sent .');
    } else {
      console.log('Both Users dont have FCM tokens.')
    }
  });


exports.iosChatNotifications = functions.firestore.document("matches/{uid}").onUpdate(
  async (change, event) => {
      console.log("New Chat Triggered")
      const conversation = change.after.data();
      const users = conversation.users;

      const sendUID = users.find(element => {
        return element != conversation.lastMessage.author;
      })

      const authorName = await getName(conversation.lastMessage.author);
      const fcm = await getFCM(sendUID);


      if (fcm && authorName) {
        const payload = {
          notification: {
            title: MESSAGE_TITLE,
            body: authorName + MESSAGE_BODY,
          },
          token: fcm,
        };

        admin.messaging().send(payload)
        .then((response) => {
          console.log('Successfully sent push notification message:', response);
          return;
        })
        .catch((error) => {
          console.log('Error sending message:', error);
          return;
        });
      } else {
        console.log("No Name for Author, or user does not have notifications set")
      }
  });


async function getName(uid) {
  const snapshot = await admin.firestore().collection("users").doc(uid).get();
  const userData = snapshot.data();
  return userData.details.firstname;
}


async function getFCM(uid) {
  const snapshotSettings = await admin.firestore().collection("settings").doc(uid).get();
  const userSettings = snapshotSettings.data();
  const fcm = userSettings.notifications.fcm;
  const isOn = userSettings.notifications.isOn;

  if (fcm == '') return null
  if (isOn) {
    return fcm;
  } else {
    return null
  }
}