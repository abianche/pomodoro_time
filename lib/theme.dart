import 'package:flutter/material.dart';

class Palette {
  static final leaf_green = Colors.green[400];
  static final blood_red = Colors.red[800];
}

ThemeData buildThemeData(BuildContext context) {
  return ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.white,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 0.0,
    ),
    scaffoldBackgroundColor: Colors.white,
    accentColor: Palette.leaf_green,
    accentColorBrightness: Brightness.light,
    sliderTheme: SliderThemeData.fromPrimaryColors(
      primaryColor: Palette.leaf_green,
      primaryColorDark: Palette.blood_red,
      primaryColorLight: Palette.leaf_green,
      valueIndicatorTextStyle: Theme.of(context).accentTextTheme.body2,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
    ),
    buttonBarTheme: ButtonBarThemeData(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
  );
}

ThemeData buildDarkThemeData(BuildContext context) {
  return ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.black,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 0.0,
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    accentColor: Palette.blood_red,
    accentColorBrightness: Brightness.dark,
    sliderTheme: SliderThemeData.fromPrimaryColors(
      primaryColor: Palette.blood_red,
      primaryColorDark: Palette.blood_red,
      primaryColorLight: Colors.amber,
      valueIndicatorTextStyle: Theme.of(context).accentTextTheme.body2,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF111111),
    ),
    buttonBarTheme: ButtonBarThemeData(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
  );
}
