const functions = require("firebase-functions");
const admin = require("firebase-admin");

const firestore = admin.firestore();

const fetchLineup = functions.https.onCall(async (data, context) => {
    const uid = data.uid;
    console.log('Fetching Lineup for: ' + uid);

    const swipedUIDs = await getHistory(uid);
    console.log('Swipe History: ' + swipedUIDs.length);

    const usersCollection = firestore.collection('users');
  
    const snapshot = await usersCollection.get();
    
    var lineup = []

    var content =  await usersCollection.get().then(querySnapshot => {
      console.log('Total Users: ' + querySnapshot.size);
      return querySnapshot.docs.map(doc => doc.data());

    });
    lineup.push(content)

    return lineup;

    // const seeking = session.filters.seeking;
    // const gender = session.info.gender;
  
    // const lineup = snapshot.docs
      // .filter((doc) => {
      //   const fid = doc.id;
      //   return !swipedUIDs.includes(fid) && fid !== uid;
      // })
      // .map((doc) => {
      //   return doc.data; // Adjust this based on your User model
      // })
      // .filter((user) => {
      //   const userGender = user.info.gender || 'None';
      //   const userSeeking = user.filters.seeking || 'None';
      //   const openString = 'Open'; // Replace with the appropriate value for your data model
  
      //   if (seeking === openString && (userSeeking === openString || !userSeeking)) {
      //     return true;
      //   }
  
      //   if (seeking !== openString) {
      //     return userGender === seeking && userSeeking === gender;
      //   }
  
      //   return userSeeking === gender;
      // });
  
    // return lineup;
  });

  async function fetchSwipes(swipe, uid) {
    const path = 'users/' + uid + '/' + swipe; 
    const snapshot = await firestore.collection(path).get();
    return snapshot.docs.map((doc) => doc.id);
  }
  
  async function getHistory(uid, swipes = ['like', 'super_like', 'pass']) {
    let all = [];
  
    for (const swipe of swipes) {
      const history = await fetchSwipes(swipe, uid);
      all = all.concat(history);
    }
  
    console.log('[SwipeHistory]', uid, all.length, 'swipes');
    return all;
  }

module.exports = {
    fetchLineup,
};