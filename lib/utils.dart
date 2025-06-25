import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalFunctions {
  // this is shown in case of success
  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color.fromARGB(255, 147, 216, 150),
      ),
    );
  }

  /// this is shown in normal case
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // this is shown in case of error
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color.fromARGB(255, 221, 139, 139),
      ),
    );
  }

  /// loading snackbar
  static void showLoadingSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color.fromARGB(255, 216, 186, 147),
      ),
    );
  }

  static final SnackBar snackBar = SnackBar(content: Text(''));

  // build Bottomsheet for edit profile
  static void myBottomSheet(
    BuildContext context, {
    AnimationController? controller,
    required Widget child,
  }) {
    showModalBottomSheet(
      transitionAnimationController: controller,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      // backgroundColor: Colors.black,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (_) {
        return child;
      },
    );
  }

  /// url launcher for opening the url in browser

  static void launchURL({String url = ''}) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}
