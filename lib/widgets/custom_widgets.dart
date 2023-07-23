import 'package:flutter/material.dart';

class CustomWidgets {
  static buildSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(fontSize: 30),
          ),
          duration: const Duration(seconds: 5),
        ),
      );
  }
}
