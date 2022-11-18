const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();

const MESSAGE_TITLE = "You have a new message!";
const MESSAGE_BODY = "You have a new message from ";
const MATCH_TITLE = "You have a new Blend!";
const MATCH_BODY = "You Blended with ";

exports.iosMatchNotifications = functions.firestore
    .document("chats/{uid}")
    .onCreate(async (snapshot, event) => {
      console.log("New Match Triggered")
      const conversation = snapshot.data();
      let users = []
      users = conversation.users
      await sendMessages(users, true);
    });


exports.iosChatNotifications = functions.firestore
    .document("chats/{uid}")
    .onUpdate(async (change, event) => {
      console.log("New Chat Triggered")
      const conversation = change.after.data();
      let users = []
      users = conversation.users

      const sendUID = arr.find(element => {
        return element != conversation.lastMessage.author;
      })

      if (sendUID) {
        const user = getUser(sendUID)
        const message = {
          notification: {
            title: MESSAGE_TITLE,
            body: MESSAGE_BODY + user.name,
          },
          token: user.fcm,
        };

        admin.messaging().send(message)
        .then((response) => {
          console.log('Successfully sent push notification message:', response);
          return;
        })
        .catch((error) => {
          console.log('Error sending message:', error);
          return;
        });
      }
    });


    const sendMessages = async (users, isMatch) => {
        const user1 = await getUser(users[0])
        const user2 = await getUser(users[1])

        const message1 = {
          notification: {
            title: MATCH_TITLE,
            body: MATCH_BODY + user2.name,
          },
          token: user1.fcm,
        };

        const message2 = {
          notification: {
            title: MATCH_TITLE,
            body: MATCH_BODY + user1.name,
          },
          token: user2.fcm,
        };
        const messages = [message1, message2];

        admin.messaging().sendAll(messages)
        .then((response) => {
          for (r in response) {
            console.log('Successfully sent push notification message:', r);
          }
          return;
        })
        .catch((error) => {
          console.log('Error sending message:', error);
          return;
        });
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

      // exports.helloFirestore = (event, context) => {
      //   const resource = context.resource;
      //   // log out the resource string that triggered the function
      //   console.log('Function triggered by change to: ' +  resource);
      //   // now log the full event object
      //   console.log(JSON.stringify(event));
      // };