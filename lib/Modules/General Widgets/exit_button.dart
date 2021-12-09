import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class Exit {
  static Future onbackpressed(BuildContext context) async {
    return await showAnimatedDialog(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
        barrierDismissible: true,
        animationType: DialogTransitionType.scale,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('Are you sure ?'),
            content: const Text('You will be exiting the app'),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    //   Navigator.of(context).pop(true);
                    SystemNavigator.pop();
                  },
                  child: const Text('Yes')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No')),
            ],
          );
        });
  }
}
