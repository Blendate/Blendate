const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();

const MESSAGE_TITLE = "You have a new message!";
const MESSAGE_BODY = "You have a new message from ";
const MATCH_TITLE = "You have a new Blend!";
const MATCH_BODY = "You Blended with ";

exports.iosMatchNotifications = functions.firestore
    .document("matches/{uid}")
    .onWrite(async (event) => {
        console.log("New Match Triggered")
      const users = event.after.get("users");
      await sendMessages(users, true);
    });


exports.iosChatNotifications = functions.firestore
    .document("chats/{uid}")
    .onWrite(async (event) => {
        console.log("New Chat Triggered")
      const users = event.after.get("users");
      await sendMessages(users, false);
    });


    const sendMessages = async (users, isMatch) => {
        const messages = [];
      
        for (const uid of users) {
          const user = await getUser(uid);
          if (user) {
            const title = isMatch ? MATCH_TITLE : MESSAGE_TITLE;
            const body = isMatch ? MATCH_BODY : MESSAGE_BODY;
      
            const message = {
              notification: {
                title: title,
                body: body + user.name,
              },
              token: user.fcm,
            };
            messages.push(message);
          }
        }
        const response = await admin.messaging().sendAll(messages);
        console.log(response);
      };
      
      const getUser = async (uid) => {
        const snapshot = await db.collection("users").doc(uid).get();
        const userData = snapshot.data();
        const name = userData.details.firstname;
        const fcm = userData.fcm;
        const push = userData.settings.notifications;
        if (push && fcm !== "") {
          return {name: name, fcm: fcm};
        } else {
          return null;
        }
      };

      exports.helloFirestore = (event, context) => {
        const resource = context.resource;
        // log out the resource string that triggered the function
        console.log('Function triggered by change to: ' +  resource);
        // now log the full event object
        console.log(JSON.stringify(event));
      };