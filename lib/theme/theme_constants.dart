import 'package:flutter/material.dart';

const primaryColor = Colors.deepPurple;

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primarySwatch: primaryColor,
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: primaryColor,
  brightness: Brightness.dark,
);
