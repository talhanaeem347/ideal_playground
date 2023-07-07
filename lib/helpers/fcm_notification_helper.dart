import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMNotificationHelper {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  static get permission  => _messaging.requestPermission();
 static  Future<String?> get token async => await _messaging.getToken();
  refreshToken(String userId) {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      // TODO: If necessary send token to application server.
      updateToken(userId: userId, token: fcmToken);
    }).onError((err) {
      log(err);
    });
  }

  Future<NotificationSettings> get settings async =>
      await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

  foregroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  static backgroundMessages(){

  }

  updateToken({required String userId, required String token}) {
    _fireStore.collection("users").doc(userId).update({token: token});
  }
}
