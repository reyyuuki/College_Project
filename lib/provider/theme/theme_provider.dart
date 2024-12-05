import 'dart:developer';

import 'package:agarwal_school/provider/theme/theme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;
  late Color _seedColor;
  late bool _isDarkMode;
  late String _varient;

  ThemeData? get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;
  Color get seedColor => _seedColor;
  String get varient => _varient;

  DynamicSchemeVariant pallete = DynamicSchemeVariant.tonalSpot;

  ThemeProvider() {
    _isDarkMode = true;
    materialTheme();
  }

  void updateTheme() {
    if (_isDarkMode) {
      _themeData = darkmode.copyWith(
          colorScheme: ColorScheme.fromSeed(
              seedColor: _seedColor,
              brightness: Brightness.dark,
              dynamicSchemeVariant: pallete,),
              );
    } else {
      log(_seedColor.toString());
      _themeData = lightmode.copyWith(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(
              seedColor: _seedColor,
              brightness: Brightness.light,
              dynamicSchemeVariant: pallete));
    }
    notifyListeners();
  }

  Future<void> materialTheme() async {
    final corepalette = await DynamicColorPlugin.getCorePalette();
    _seedColor = corepalette != null
        ? Color(corepalette.primary.get(40))
        : const Color(0xFF94FB35);
    updateTheme();
  }

  void lightTheme() {
    _isDarkMode = false;
    updateTheme();
    notifyListeners();
  }

  void darkTheme() {
    _isDarkMode = true;
    updateTheme();
    notifyListeners();
  }
}
