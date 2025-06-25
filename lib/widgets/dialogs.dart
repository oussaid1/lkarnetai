import 'package:flutter/material.dart';

import '../const/constents.dart';

class Dialogs {
  static Future<bool> confirmDialogue(context,
      {String? title,
      String? message,
      VoidCallback? onOK,
      VoidCallback? onCancel}) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'Confirm !'),
        content: Text(message ?? 'Are you sure ?'),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'),
          ),
        ],
      ),
    ).then((value) {
      if (value ?? false) {
        onOK;
        return Future.value(true);
      } else {
        onCancel;
        return Future.value(false);
      }
    });
  }

  static Future<void> dialogSimple(BuildContext context,
      {List<Widget>? widgets, String? title}) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        useRootNavigator: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$title'),
            actionsPadding: EdgeInsets.only(left: 8, right: 8),
            actions: widgets,
          );
        });
  }

  static Future<void> botomUpDialog(BuildContext context, Widget widget,
      {height}) async {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: height ?? MediaQuery.of(context).size.height * 0.7,
            child: SizedBox.expand(child: widget),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  static snackBar(String text) => SnackBar(
        content: Text('$text'),
        backgroundColor: AppConstants.greenOpacity,
      );
  static snackBarError(String text) =>
      SnackBar(content: Text('$text'), backgroundColor: Colors.red);
}
