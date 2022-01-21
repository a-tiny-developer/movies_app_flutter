import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.deepPurple;

  static final ThemeData lighTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
      color: primary,
    ),
    // textTheme: lightTextTheme,
  );

  // static const TextTheme lightTextTheme = TextTheme();

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      color: primary,
    ),
    primaryColor: primary,
    // textTheme: darkTextTheme,
  );

  // static const TextTheme darkTextTheme = TextTheme();
}
