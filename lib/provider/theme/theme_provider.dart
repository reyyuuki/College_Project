import 'dart:developer';

import 'package:agarwal_school/provider/theme/theme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;
  Color _seedColor = Colors.purple;
  bool _isDarkMode = false;
  bool _isLightMode = true;
  bool _isMaterial = true;
  late String _variant;

  ThemeData? get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;
  bool get isLightMode => _isLightMode;
  bool get isMaterial => _isMaterial;
  Color get seedColor => _seedColor;
  String get varient => _variant;

  DynamicSchemeVariant palette = DynamicSchemeVariant.tonalSpot;

  ThemeProvider() {
    var box = Hive.box("app-data");
    _isDarkMode = box.get("isDarkMode", defaultValue: false);
    _isLightMode = box.get("isLightMode", defaultValue: true);
    _isMaterial = box.get("isMaterial", defaultValue: true);
    _variant = box.get("palette", defaultValue: "TonalSpot");
    setPaletteColor(_variant);
    if (_isMaterial) {
      materialTheme();
    } else {
      int value = box.get("seedColor", defaultValue: Colors.purple.value);
      MaterialColor color = MaterialColor(value, getMaterialColorSwatch(value));
      updateSeedColor(color);
    }
    log("new ${_seedColor.toString()}");
    updateTheme();
  }

  void updateTheme() {
    if (_isDarkMode) {
      _themeData = darkmode.copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
          dynamicSchemeVariant: palette,
        ),
      );
    } else if (_isLightMode) {
      _themeData = lightmode.copyWith(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(
              seedColor: _seedColor,
              brightness: Brightness.light,
              dynamicSchemeVariant: palette));
    } else {
      _themeData = darkmode.copyWith(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
              seedColor: _seedColor,
              brightness: Brightness.dark,
              surface: Colors.black,
              dynamicSchemeVariant: palette));
    }

    Hive.box("app-data").put("isDarkMode", _isDarkMode);
    Hive.box("app-data").put("isLightMode", _isLightMode);
    notifyListeners();
  }


Future<void> materialTheme() async {
  final corepalette = await DynamicColorPlugin.getCorePalette();
  if (corepalette != null) {
    _seedColor = Color(corepalette.primary.get(40)); 
    log("Material theme color updated: $_seedColor");
  } else {
    _seedColor = const Color(0xFF94FB35); 
    log("Dynamic color not available. Using fallback color.");
  }
  _isMaterial = true;
  Hive.box("app-data").put("isMaterial", true);
  updateTheme(); 
}


  void lightTheme() {
    _isDarkMode = false;
    _isLightMode = true;
    updateTheme();
  }

  void oledTheme() {
    _isDarkMode = false;
    _isLightMode = false;
    updateTheme();
  }

  void darkTheme() {
    _isDarkMode = true;
    _isLightMode = false;
    updateTheme();
  }

  void updateSeedColor(Color newColor) {
    var box = Hive.box("app-data");
    _seedColor = newColor;
    _isMaterial = false;
    box.put('seedColor', newColor.value);
    box.put('isMaterial', false);
    log("update $seedColor");
    updateTheme();
    notifyListeners();
  }


  void setPaletteColor(String newVariant) {
    switch (newVariant) {
      case "Content":
        palette = DynamicSchemeVariant.content;
        break;
      case "Expressive":
        palette = DynamicSchemeVariant.expressive;
        break;
      case "Fidelity":
        palette = DynamicSchemeVariant.fidelity;
        break;
      case "FruitSalad":
        palette = DynamicSchemeVariant.fruitSalad;
        break;
      case "MonoChrome":
        palette = DynamicSchemeVariant.monochrome;
        break;
      case "Neutral":
        palette = DynamicSchemeVariant.neutral;
        break;
      case "Rainbow":
        palette = DynamicSchemeVariant.rainbow;
        break;
      case "TonalSpot":
        palette = DynamicSchemeVariant.tonalSpot;
        break;
      case "Vibrant":
        palette = DynamicSchemeVariant.vibrant;
        break;
      default:
        palette = DynamicSchemeVariant.tonalSpot;
    }
    updateTheme();
    _variant = newVariant;
    Hive.box("app-data").put("palette", _variant);
  }

  Map<int, Color> getMaterialColorSwatch(int colorValue) {
    Color color = Color(colorValue);
    return {
      50: color.withOpacity(.1),
      100: color.withOpacity(.2),
      200: color.withOpacity(.3),
      300: color.withOpacity(.4),
      400: color.withOpacity(.5),
      500: color.withOpacity(.6),
      600: color.withOpacity(.7),
      700: color.withOpacity(.8),
      800: color.withOpacity(.9),
      900: color.withOpacity(1),
    };
  }
}
