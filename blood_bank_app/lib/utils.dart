import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar({
    required BuildContext context,
    required String msg,
    Color? color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
        ),
        backgroundColor: color,
      ),
    );
  }
}
