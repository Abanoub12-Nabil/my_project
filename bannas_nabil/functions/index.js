const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Initialize Firebase Admin SDK
admin.initializeApp();

// Scheduled notification every day at 9 AM
exports.sendNotificationToAll = functions.pubsub
  .schedule("every day 09:00")
  .onRun((context) => {
    const payload = {
      notification: {
        title: "تذكير يومي",
        body: "هذا هو التذكير اليومي لجميع المستخدمين",
      },
    };

    // Send notification to all users subscribed to 'all' topic
    return admin.messaging().sendToTopic("all", payload)
      .then((response) => {
        console.log("تم إرسال الإشعار بنجاح:", response);
      })
      .catch((error) => {
        console.log("خطأ في إرسال الإشعار:", error);
      });
  });
