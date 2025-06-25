import 'package:flutter/material.dart';

import '../const/constents.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    this.title,
    this.actions,
    this.leading,
  }) : super(key: key);
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      leading: leading,
      title: title,
      elevation: 0,
      shadowColor: Colors.transparent,
      excludeHeaderSemantics: true,
      //toolbarHeight: 40,
      backgroundColor: AppConstants.whiteOpacity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radius),
          bottom: Radius.circular(AppConstants.radius),
        ),
      ),
    );
  }
}
