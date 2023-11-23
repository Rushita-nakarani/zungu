import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/notification_info_model.dart';

class PushNotification {
// Create constructor...
  PushNotification._privateConstructor();

// Instance getter...
  static final PushNotification _instance =
      PushNotification._privateConstructor();

// Class instance...
  static PushNotification get instance => _instance;

  /// On message received...
  void Function(NotificationInfoModel, NotificationType)? onMessageReceived;

  // Notification setup methods setup...
  Future<void> pushNotificationsMethodsSetup() async {
    // 1. This method call when app in [Terminated] state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) => decodeNotificationMessage(
        message,
        NotificationType.terminated,
      ),
      onError: (error) {
        print("Get Initial Message Error: $error");
      },
    );

    // 2. This method only call when App in [Forground] it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) => decodeNotificationMessage(
        message,
        NotificationType.forground,
      ),
      onError: (error) {
        print("On Message Error: $error");
      },
    );

    // 3. This method only call when App in [Background] and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) => decodeNotificationMessage(
        message,
        NotificationType.background,
      ),
      onError: (error) {
        print("On Message Opened App Error: $error");
      },
    );
  }

  // Decode notification message...
  void decodeNotificationMessage(
    RemoteMessage? message,
    NotificationType notificationType,
  ) {
    print(message?.toMap());
    if (onMessageReceived != null && message != null) {
      onMessageReceived!(
        notificationInfoModelFromJson(message.toMap()),
        notificationType,
      );
    }
  }

  // Get push notification permission...
  Future<bool> getNotificationPermission() async {
    if (Platform.isAndroid) {
      return Permission.notification.isGranted;
    } else {
      await FirebaseMessaging.instance.requestPermission();
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true,);

      return Permission.notification.isGranted;
    }
  }

  //Get FCM device token if Notificatoin is granted...
  Future<String> getFCMToken() async {
    try {
      await getNotificationPermission();
      // if (await getNotificationPermission()) {
      // Check connectivity because internet is required if notification is granted....
      await ApiCall.instance.checkConnectivity();

      final String? fcmId = await FirebaseMessaging.instance.getToken();

      // print("+ + + + + + + + + FCM Id : $fcmId + + + + + + + + + ");

      return fcmId ?? "";
      // } else {
      //   return "";
      // }
    } catch (error) {
      print("Error while fetching FCM token:- $error");
      return "";
    }
  }

  // Logout user, delete's firebase instance so that notification is not received on mobile...
  Future<void> logout() async {
    return FirebaseMessaging.instance.deleteToken();
  }
}

enum NotificationType {
  terminated,
  forground,
  background,
}
