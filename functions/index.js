"use strict";

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

//admin.initializeApp( functions.config().firebase );
/// get token from firestore
// exports.getToken = functions.https.onCall(async (id, context) => {
//   const token = await admin.firestore().collection("users").doc(id).get('token');
//   /// log token
//     console.log('token from get token fbs'+token);
//   return token.data().token;
// });

/// return all the elements in the cloud firestore collection 'KitchenElements' where availability is 0
//var token = 'faIwjMHgT32XZQLY1LfOMo:APA91bFarbKci9D08Z9an2__beqWV8h4fWLJf3xsrdxYXDIYrJxuTKsuU5I6vKWVAOktcIzpsIuxw990MB64aWiPY6KQonsH4EsbT4PVKQ0RJhKEps1h0LHpIsy89G9WoecNRQL0ZW-R';
/// listen for changes in the cloud firestore collection 'KitchenElements'  and send a notification to the user when a new element's availability is changed to 0
exports.sendNotification = functions.firestore
  .document("KitchenElements/{elementId}")
  .onUpdate(async (change, context) => {
    functions.logger.info("New value for element:", context.params.elementId);
    /// get user token from firestore
    const token = await admin
      .firestore()
      .collection("users")
      .doc(id)
      .get("token");
    const element = change.after.data();
    // const token = await admin
    //   .firestore()
    //   .collection("tokens")
    //   .doc(element.userId)
    //   .get();
    const elements = await admin
      .firestore()
      .collection("KitchenElements")
      .where("availability", "==", 0)
      .get();
    var elementsList = elements.docs.map((doc) => doc.data());
    const payload = {
      notification: {
        id: element.id,
        title: "You have ${elementsList.length} elements unavailable",
        body: element.name,
        icon: "https://img.icons8.com/external-flaticons-lineal-color-flat-icons/344/external-empty-web-store-flaticons-lineal-color-flat-icons.png",
        click_action: "https://kitchen-elements.web.app/",
      },
    };
    const options = {
      priority: "high",
      timeToLive: 60 * 60 * 24,
    };
    return admin.messaging().sendToDevice(token, payload, options);
  });
