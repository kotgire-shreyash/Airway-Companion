import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

// function for basic notification
Future<void> CreateBasicNotification(
    {required String title, required String body}) async {
  print("HERE");
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 4,
      channelKey: 'basic_channel',
      title: title,
      body: body,
    ),
  );
}

// function to schedule notification
Future<void> CreateReminderNotification(
    {required String title,
    required String body,
    required DateTime dateTimeobject}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 5,
      channelKey: 'basic_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.Default,
      // icon: 'asset://assets/images/plane.jpg'
    ),
    actionButtons: [
      NotificationActionButton(key: 'Mark_Done', label: 'Mark Done'),
    ],
    schedule: NotificationCalendar.fromDate(
      date: dateTimeobject.add(
        Duration(seconds: 30),
        // DateTime.now().subtract(Duration(hours: 2));   // this should be used to schedule 2 hours before
      ),
    ),
  );
}
