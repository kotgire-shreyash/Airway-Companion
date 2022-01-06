import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

Widget permissionAlertDialogue(BuildContext context) {
  return AlertDialog(
    title: Text('Allow Notifications'),
    content: Text('Our app would like to send You Notifications'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'Don\'t Allow',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ),
      TextButton(
        onPressed: () =>
            AwesomeNotifications().requestPermissionToSendNotifications(),
        child: Text(
          'Allow',
          style: TextStyle(
              color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}
