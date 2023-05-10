import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPlatformService {
  static Android android = Android();
}

class Android {
  AndroidNotificationDetails initialize({required AndroidNotificationChannel channel, String? icon}) {
    return AndroidNotificationDetails(channel.id, channel.name,
        channelDescription: channel.description,
        priority: Priority.high,
        // channelAction: AndroidNotificationChannelAction.createIfNotExists,
        icon: icon,
        actions: [
          // AndroidNotificationAction(channel.id, "OK"),
          // AndroidNotificationAction(channel.id, "Cancel")
        ],
        importance: Importance.max);
  }

  AndroidInitializationSettings initializationSettingAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
}
