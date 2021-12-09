import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToast {
  static final FToast toast = FToast();
  static void display(String message) {
    toast.showToast(
      child: Container(
        height: 25,
        width: 110,
        color: Colors.grey.shade100,
        child: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void init(BuildContext context) {
    toast.init(context);
  }
}
