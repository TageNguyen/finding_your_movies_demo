import 'dart:io';

import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// used for showing messages
class MessageHelper {
  /// show toast message on top of screen
  /// if [isErrorMessage], bubble's background will be red
  /// else green
  static void showToastMessage(String message, {bool isErrorMessage = false}) async {
    await Fluttertoast.cancel(); // hide current toast
    if (message.isEmpty) {
      return;
    }
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: (isErrorMessage ? Colors.red : Colors.green).withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 13.0,
      timeInSecForIosWeb: 3,
    );
  }

  /// show a dialog with a notification message
  /// dialog will has cupertino style if [Platform.isIOS]
  /// else material style
  static Future<T?> showNotificationDialog<T extends Object?>(
      BuildContext context, String message,
      {String? title}) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(Translations.of(context).ok),
            ),
          ],
        ),
      );
    }
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(Translations.of(context).ok),
          ),
        ],
      ),
    );
  }
}
