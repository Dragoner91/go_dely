import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  /*
  Future<void> _requestPermissionLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  PushMessage _mapMessage(RemoteMessage message) {
    final notification = PushMessage(
        messageId:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        sentDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        imageUrl: message.notification!.android?.imageUrl);
    return notification;
  }

  Future<void> initializeLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final initializationSettings = 
      InitializationSettings(
        android: initializationSettingsAndroid,
      );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  */

  Future<bool> requestPermission() async {
    final settingsStatus = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    //await _requestPermissionLocalNotifications();
    return settingsStatus.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<bool> get isAuthorized async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<String?> get token async {
    return await _firebaseMessaging.getToken();
  }
  /*
  void setForegroundListener(handle) {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification == null) return;
      final notification = _mapMessage(message);
      handle(notification);
    });
  }

  Future<void> setBackgroundListener(Function(PushMessage) handle) async {
    await _firebaseMessaging.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final notification = _mapMessage(message);
      handle(notification);
      //do something (go to a screen, etc.)
    });
  }
  */

}