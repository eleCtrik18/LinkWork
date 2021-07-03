// import * as functions from 'firebase-functions';
// import * as admin from 'firebase-admin';
// admin.initializeApp();
// const fcm = admin.messaging();

// export const sendNotif = functions.https.onRequest((request, response) => {

//    const tokens = request.query.tokens;
//    const payload: admin.messaging.MessagingPayload = {
//    notification: {
//       title: '[TEST-123] title...',
//       body: `[TEST-123]  body of message... `,          
//       click_action: 'FLUTTER_NOTIFICATION_CLICK',
//       tag: "news",
//       data: "{ picture: 'https://i.imgur.com/bY2bBGN.jpg', link: 'https://example.com' }"
//     }
//   };
//   const res = fcm.sendToDevice(tokens, payload);
//   response.send(res);
// });