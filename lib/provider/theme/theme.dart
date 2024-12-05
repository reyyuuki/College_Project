import 'package:flutter/material.dart';

const color = Colors.purple;
ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme:
        ColorScheme.fromSeed(seedColor: color, brightness: Brightness.light));

ThemeData darkmode = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme:
        ColorScheme.fromSeed(seedColor: color, brightness: Brightness.dark));
