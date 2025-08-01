import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastUtil {
  static void showToast(String message, {Color bgColor = Colors.black}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: bgColor,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
