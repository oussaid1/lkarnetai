import 'package:lkarnet/components.dart';
import 'package:flutter/material.dart';

class MThemeData {
  const MThemeData._();
  /////// light theme
  static const primaryColor = Color.fromARGB(255, 255, 136, 0);
  static const primaryVarient = Color(0xFFCA950F);
  static const secondaryColor = Color(0xFF0097D3);
  static const secondaryVarient = Color(0xFF7E3BC1);
  static const hintColor = Color.fromARGB(255, 43, 43, 43);
  static const almostWhiteColor = Color(0xFFF6FBFF);
  static const errorColor = Color(0xFFE17979);
  ////// Dark Theme
  static const primaryColorDark = Color.fromARGB(255, 255, 136, 0);
  static const primaryVarientDark = Color(0xFFCA950F);
  static const secondaryColorDark = Color(0xFFEBA696);
  static const secondaryVarientDark = Color(0xFF7E3BC1);
  static const hintColorDark = Color(0xFF757575);
  static const almostBlackColorDark = Color.fromARGB(0, 32, 27, 27);
  static const errorColorDark = Color(0xFF9b374d);

// black and white
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFFF0F0F0);
  static final blurWhite = Colors.white.withOpacity(0.5);
  /////////////////////
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: primaryColor,
    primaryContainer: primaryVarient,
    secondary: secondaryColor,
    secondaryContainer: secondaryColor,
    surface: white,
    error: errorColor,
    onError: white,
    onPrimary: almostWhiteColor,
    onSecondary: almostBlackColorDark,
    onSurface: black,
    brightness: Brightness.light,
    //onSecondaryContainer:secondaryColor
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: primaryColorDark,
    primaryContainer: primaryVarientDark,
    secondary: secondaryColorDark,
    secondaryContainer: secondaryColor,
    surface: almostBlackColorDark,
    error: errorColor,
    onError: white,
    onPrimary: white,
    onSecondary: almostWhiteColor,
    onSurface: white,
    brightness: Brightness.dark,
    // onSecondaryContainer:
  );

  static final ButtonStyle raisedButtonStyleCancel = ElevatedButton.styleFrom(
    textStyle: _textTheme.labelLarge!, backgroundColor: Colors.transparent,
    // backgroundColor: Colors.transparent,
    disabledForegroundColor: primaryColor.withOpacity(0.38),
    disabledBackgroundColor: primaryColor.withOpacity(0.12),
    // minimumSize: const Size(100, 50),
    animationDuration: const Duration(milliseconds: 200),
    shadowColor: primaryColor,
    enableFeedback: true,
    elevation: 0,
    fixedSize: const Size(100, 40),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    shape: const RoundedRectangleBorder(
      side: BorderSide(color: MThemeData.primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
  static final ButtonStyle raisedButtonStyleSave = ElevatedButton.styleFrom(
    textStyle: _textTheme.labelLarge,
    disabledForegroundColor: primaryColor.withOpacity(0.38),
    disabledBackgroundColor: primaryColor.withOpacity(0.12),
    animationDuration: const Duration(milliseconds: 200),
    shadowColor: primaryColor,
    enableFeedback: true,
    fixedSize: const Size(100, 40),
    elevation: 0,
    //  backgroundColor: Colors.transparent,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
  // static final elevatedButtonStyleSave = ElevatedButton.styleFrom(
  //   maximumSize: const Size(100, 50),
  //   minimumSize: const Size(100, 50),
  //   textStyle: _textTheme.button,
  //   // backgroundColor: primaryColor,
  //   elevation: 0,
  //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //   shape: const RoundedRectangleBorder(
  //     side: BorderSide(color: primaryColor),
  //     borderRadius: BorderRadius.all(Radius.circular(6)),
  //   ),
  // );
  // static final elevatedButtonStyleCancel = ElevatedButton.styleFrom(
  //   maximumSize: const Size(100, 50),
  //   minimumSize: const Size(100, 50),
  //   textStyle: _textTheme.button,
  //   elevation: 0,
  //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //   shape: const RoundedRectangleBorder(
  //     side: BorderSide(color: primaryColor),
  //     borderRadius: BorderRadius.all(Radius.circular(6)),
  //   ),
  // );
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      typography: Typography(),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     textStyle: _textTheme.button!,
      //     onSurface: colorScheme.primary.withOpacity(0.1),
      //     padding: const EdgeInsets.symmetric(horizontal: 8),
      //     shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(6)),
      //     ),
      //   ),
      // ),
      // ElevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     textStyle: _textTheme.button!,
      //     onSurface: colorScheme.primary.withOpacity(0.1),
      //     padding: const EdgeInsets.symmetric(horizontal: 8),
      //     shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(6)),
      //     ),
      //   ),
      // ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        shape: const CircleBorder(),
      ),
      // buttonTheme: ButtonThemeData(
      //   disabledColor: colorScheme.primary.withOpacity(0.1),
      //   //  buttonColor: colorScheme.secondary,
      //   minWidth: 88,
      //   height: 36,
      //   colorScheme: colorScheme,
      //   textTheme: ButtonTextTheme.normal,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(10)),
      //   ),
      // ),
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: colorScheme.surface,
      // appBarTheme: AppBarTheme(
      //   //toolbarHeight: 80,
      //   // titleTextStyle: _textTheme.headline6!.copyWith(
      //   //     // color: colorScheme.onPrimary,
      //   //     ),
      //   color: colorScheme.secondary,
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: colorScheme.onBackground),
      // ),
      hintColor: hintColor,

      // switchTheme: SwitchThemeData(
      //   thumbColor: MaterialStateProperty.all(primaryColor),
      //   trackColor: MaterialStateProperty.all(primaryVarient),
      // ),
      // tabBarTheme: TabBarTheme(labelColor: ),
      iconTheme: IconThemeData(color: colorScheme.surface),
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      cardColor: colorScheme.surface,

      //iconTheme: IconThemeData(color: Color.fromARGB(255, 27, 27, 27)),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
      //cardTheme: CardTheme(color: colorScheme.primary),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          //color: secondaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: _textTheme.bodyMedium!.apply(color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        waitDuration: const Duration(milliseconds: 100),
        showDuration: const Duration(milliseconds: 50),
        preferBelow: true,
      ),
      colorScheme: colorScheme.copyWith(surface: colorScheme.surface),
      dialogTheme: DialogThemeData(backgroundColor: colorScheme.secondary),
    );
  }

  static const _bold = FontWeight.bold;
  static const _semiBold = FontWeight.w600;
  static const _medium = FontWeight.w500;
  static const _regular = FontWeight.w400;
  static const _light = FontWeight.w300;

  static final TextTheme _textTheme = TextTheme(
      displayLarge: GoogleFonts.sansita(
          fontWeight: _bold, fontSize: 28.0, color: Colors.black),
      /***************************** */
      displayMedium: GoogleFonts.sansita(
          fontWeight: _semiBold, fontSize: 24.0, color: Colors.black),
      /***************************** */
      displaySmall: GoogleFonts.sansita(
          fontWeight: _semiBold, fontSize: 20.0, color: Colors.black),
      /***************************** */
      headlineMedium: GoogleFonts.sansita(
          fontWeight: _medium, fontSize: 18.0, color: Colors.black),
      /***************************** */
      headlineSmall: GoogleFonts.sansita(
          fontWeight: _regular, fontSize: 16.0, color: Colors.black),
      /***************************** */
      titleLarge: GoogleFonts.sansita(
          fontWeight: _regular, fontSize: 16.0, color: Colors.black),
      /***************************** */
      titleMedium: GoogleFonts.sansita(
          fontWeight: _regular, fontSize: 14.0, color: Colors.black),
      /***************************** */
      titleSmall: GoogleFonts.sansita(
          fontWeight: _light, fontSize: 12.0, color: hintColor),
      /***************************** */
      bodySmall: GoogleFonts.sansita(
          fontWeight: _light, fontSize: 12.0, color: Colors.black),
      /***************************** */
      labelSmall: GoogleFonts.sansita(
          fontWeight: _light, fontSize: 12.0, color: hintColor),
      /***************************** */
      bodyLarge: GoogleFonts.sansita(
          fontWeight: _regular, fontSize: 16.0, color: Colors.black),
      /***************************** */
      bodyMedium: GoogleFonts.robotoMono(
          fontWeight: _regular, fontSize: 14.0, color: Colors.black),
      /***************************** */

      labelLarge: GoogleFonts.sansita(
        fontWeight: _semiBold,
        fontSize: 16.0,
      ));
}
