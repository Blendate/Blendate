const admin = require('./node_modules/firebase-admin');
const serviceAccount = require("./serviceAccountKey.json");
const data = require("./BlendateFirebase.json");
const collectionKey = "mock_users"; 
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://firebase-adminsdk-qbbc9@blendate-78988.iam.gserviceaccount.com"
});

const firestore = admin.firestore();
const settings = {timestampsInSnapshots: true};

firestore.settings(settings);
if (data && (typeof data === "object")) {
    Object.keys(data).forEach(docKey => {
        let user = data[docKey]
        let back = {placement:1,url:`https://source.unsplash.com/random/1000x1000/?landscape&${docKey}` }
        let avatar = {placement:0,url:`https://source.unsplash.com/random/500x500/?portrait&${docKey}` }
        let image3 = {placement:2,url:`https://source.unsplash.com/random/500x800/?person&${docKey}${3}` }
        let image4 = {placement:3,url:`https://source.unsplash.com/random/500x800/?person&${docKey}${4}` }
        let image5 = {placement:4,url:`https://source.unsplash.com/random/500x800/?person&${docKey}${5}` }
        let image6 = {placement:5,url:`https://source.unsplash.com/random/500x800/?person&${docKey}${6}` }
        let image7 = {placement:6,url:`https://source.unsplash.com/random/500x800/?person&${docKey}${7}` }
        let image8 = {placement:7,url:`https://source.unsplash.com/random/500x800/?person&${docKey}${8}` }
        user.photos = [back,avatar,image3,image4, image5, image6, image7, image8]
        user.photos.push(back)
        user.birthday = new Date()
        console.log(user)
        firestore.collection(collectionKey).doc().set(data[docKey]).then((res) => {
            console.log("Document " + docKey + " successfully written!");
        }).catch((error) => {
        console.error("Error writing document: ", error);
        });
    });
}
// (this.raw).strftime('%B %d, %Y at %I:%M:%S %p UTC-5')
// "https://source.unsplash.com/random/250x250/?portrait"
// "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80"
// "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"