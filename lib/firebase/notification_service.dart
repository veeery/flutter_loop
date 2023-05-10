import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_loop/firebase/notification_option.dart';
import 'package:flutter_loop/firebase/notification_platform_service.dart';
import 'package:get/get.dart';


class NotificationService {
  static getPermission() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if ((settings.authorizationStatus == AuthorizationStatus.authorized) ||
        (settings.authorizationStatus == AuthorizationStatus.provisional)) {
      FirebaseMessaging.onBackgroundMessage(firebaseBackgroundService);
    }
  }

  //Handler Foreground Notifications
  static Future<void> firebaseForegroundService() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .initialize(InitializationSettings(android: NotificationPlatformService.android.initializationSettingAndroid));

    if (GetPlatform.isAndroid) {
      // Android
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? androidNotification = message.notification?.android;

        if (notification != null && androidNotification != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: NotificationPlatformService.android
                      .initialize(channel: androidChannel, icon: androidNotification.smallIcon)));
        }
      });
    }

    // Create Channel for Android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    await FirebaseMessaging.instance.subscribeToTopic("support");
  }

  // Handler Background Notifications
  static Future<void> firebaseBackgroundService(RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
  }

  static AndroidNotificationChannel androidChannel = const AndroidNotificationChannel(
    'flutter loop',
    'Flutter Loop',
    description: 'Flutter Loop Channel Notifications',
    importance: Importance.high,
    showBadge: true,
  );

  static Future<void> subscribeTopic(String topic) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeTopic(String topic) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.unsubscribeFromTopic(topic);
  }
}
