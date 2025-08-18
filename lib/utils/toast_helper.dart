import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {

  /// اظهار رسالة Toast بنوعية (نجاح/خطأ)
  static void showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? Colors.redAccent.shade700 : Colors.green.shade600,
      textColor: Colors.white,
      fontSize: 16.0,
      webBgColor: isError ? "linear-gradient(to right, #e53935, #e35d5b)" : "linear-gradient(to right, #43a047, #66bb6a)",
      webPosition: "center",
    );
  }
}
