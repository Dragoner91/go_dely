import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_dely/aplication/model/push_message.dart';
import 'package:go_dely/aplication/services/i_notification_handler.dart';

class NotificationsProvider{
  INotificationHandler handler;
  int pushNumberId = 0;

  NotificationsProvider(this.handler);

  void init() {
    print('NotificationsProvider initializated');
    handler.initializeLocalNotifications();
    _onForegroundMessage();
    _setBackgroundListener();
  }

  void handleRemoteMessage( RemoteMessage message ) {
    if (message.notification == null) return;
    
    final notification = PushMessage(
      messageId: message.messageId
        ?.replaceAll(':', '').replaceAll('%', '')
        ?? '',
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
        ? message.notification!.android?.imageUrl
        : message.notification!.apple?.imageUrl
    );
    print('notificacion!');
    handler.showLocalNotification(
      id: ++pushNumberId,
      title: notification.title,
      body: notification.body,
      data: notification.data,
    );
  }

  void _onForegroundMessage(){ 
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void _setBackgroundListener() {
    handler.setBackgroundListener((PushMessage message) {
      handler.showLocalNotification(
        id: message.hashCode,
        title: message.title,
        body: message.body,
        data: message.data,
      );
    });
  }
}