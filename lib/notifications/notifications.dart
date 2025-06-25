import 'package:flutter/material.dart';

import '../components.dart';
import 'utilities.dart';

class MNotificationModel {
  // singleton
  // _NotificationModel._();
  static const String expiredItems = 'expiredItems';
  static const String _channelKey1 = 'remember_to_buy_items';
  static const String _channelName1 = 'Remember to Buy Items';
  static const String _channelKey2 = 'schedule_remember_to_register_items';
  static const String _channelName2 = 'Schedule Remember to Register Items';
  static const String dateTime = 'DateTime';
  static const String iconUri = 'resource://drawable/res_notification_app_icon';
  static final MNotificationModel _singleton = MNotificationModel._();
  factory MNotificationModel() {
    return _singleton;
  }
  MNotificationModel._();
  //static AwesomeNotifications _notification = AwesomeNotifications();
  //static AwesomeNotifications get notification => _notification;
  // static Future<void> initialize() async {
  //   _notification.initialize(iconUri, channels);
  // }

  static List<NotificationChannel> channels = [
    NotificationChannel(
      channelKey: _channelKey1,
      channelName: _channelName1,
      defaultColor: Colors.teal,
      importance: NotificationImportance.High,
      channelShowBadge: true,
      channelDescription: 'This channel is used to show expired items',
      enableLights: true,
      enableVibration: true,
      //vibrationPattern: [0, 500, 200, 500],
      icon: iconUri,
      ledColor: Colors.teal,
    ),
    NotificationChannel(
      channelKey: _channelKey2,
      channelName: _channelName2,
      defaultColor: Colors.teal,
      importance: NotificationImportance.High,
      channelShowBadge: true,
      channelDescription: 'This channel is used to show expired items',
      enableLights: true,
      enableVibration: true,
      //vibrationPattern: [0, 500, 200, 500],
      icon: iconUri,
      ledColor: Colors.teal,
    ),
  ];
  static Future<void> createOneTimeNotification({String? expired}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: _channelKey1,
        title: '${Emojis.food_bagel + Emojis.food_banana} Go Buy Some Food!!!',
        body: 'one time You have $expired items expired ...',
        // bigPicture: 'asset://assets/notification_map.png',
        notificationLayout: NotificationLayout.BigText,
      ),
    );
  }

  static Future<void> createBuyReminderNotification(
      {bool itemsExpired = false,
      String? expired,
      required DateTime dateTime}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: _channelKey2,
        title:
            "${Emojis.person_role_woman_mechanic + Emojis.paper_books} Dont't forget to register items !!!",
        body: 'scheduled You have $expired items expired ...',
        // bigPicture: 'asset://assets/notification_map.png',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'MARK_DONE',
          label: 'Mark Done',
        ),
      ],
      schedule: NotificationCalendar(
        //weekday: dateTime.weekday,
        hour: 4, //dateTime.hour,
        minute: 0, // dateTime.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
        allowWhileIdle: true,
      ),
    );
  }

  static void cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }

  static Future<void> calldispatcher(String id) async {
    Workmanager().executeTask((task, inputData) async {
      await MNotificationModel.createOneTimeNotification();
      await MNotificationModel.createBuyReminderNotification(
          itemsExpired: true, expired: '2', dateTime: DateTime.now());
      return Future.value(true);
    });
  }
}
