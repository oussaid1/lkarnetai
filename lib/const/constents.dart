import 'package:flutter/material.dart';

import '../components.dart';

class AppAssets {
  static final String assetName = 'assets/images/logo.svg';
  static final String google = 'assets/images/google.svg';
  static final String pinkCircle = 'assets/images/pinkball.png';
  static final String purpleCircle = 'assets/images/purpleball.png';
  static final String blueCircle = 'assets/images/blueball.png';
  ////////////////////////////////////////////////////////////////////////////////
  static final Widget svgIcon = SvgPicture.asset(
    assetName,
    semanticsLabel: 'app logo',
    width: 100,
    height: 100,
  );
  static final Widget googleSvgIcon = SvgPicture.asset(
    google,
    semanticsLabel: 'google icon',
    width: 24,
    height: 24,
  );

  static final Widget pinkCircleWidget = Image.asset(
    pinkCircle,
    semanticLabel: 'A circle',
    width: 100,
    height: 100,
  );

  static final Widget purpleCircleWidget = Image.asset(
    purpleCircle,
    semanticLabel: 'A cirle',
    width: 100,
    height: 100,
  );

  static final Widget blueCircleWidget = Image.asset(
    blueCircle,
    semanticLabel: 'A circle',
    width: 100,
    height: 100,
  );
}

class AppConstants {
  static const double radius = (6.0);
  static const double padding = (8.0);
  static const double margin = (8.0);
  static const double borderRadius = (6.0);
  static const double borderWidth = (2.0);
  static const double opacity = (0.2);
  // ignore: deprecated_member_use
  static final Color greenOpacity = Colors.green.withOpacity(opacity);
  static final Color whiteOpacity = Colors.white.withOpacity(opacity);
  static final Color blackOpacity = Colors.black.withOpacity(opacity);
  static final Color hintColor = Color.fromARGB(
    255,
    36,
    36,
    36,
  ).withOpacity(0.6);
  static final Color primaryColor = Color.fromARGB(255, 150, 163, 235);
  static final Color accentColor = Color.fromARGB(255, 235, 205, 150);
  // list of colors
  static const List<Color> myGradients = [Color(0xD52A76DA), Color(0xBDD43FCD)];
}
