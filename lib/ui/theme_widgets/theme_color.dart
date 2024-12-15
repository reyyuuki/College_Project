import 'dart:developer';
import 'dart:ui';

import 'package:school_app/core/icons/icons_broken.dart';
import 'package:school_app/provider/theme/theme_provider.dart';
import 'package:checkmark/checkmark.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ThemeColor extends StatefulWidget {
  const ThemeColor({super.key});

  @override
  State<ThemeColor> createState() => _ThemeModesState();
}

class _ThemeModesState extends State<ThemeColor> {
  Color seedColor = Colors.purple;
  List<String> paletteList = [
    "Content",
    "Expressive",
    "Fidelity",
    "FruitSalad",
    "MonoChrome",
    "Neutral",
    "RainBow",
    "TonalSpot",
    "Vibrant"
  ];


  @override
  Widget build(BuildContext context) {
   int value = Hive.box("app-data").get("seedColor",defaultValue: 0xff9c27b0);
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    seedColor = Color(value);
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.6))
          ],
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: const ListTile(
              leading: Icon(Broken.designtools),
              title: Text(
                "Customization",
                style: TextStyle(
                  fontFamily: "LexendDeca",
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20))),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Broken.colorfilter,
                    size: 28,
                  ),
                  title: const Text(
                    "Dynamic Coloring",
                    style: TextStyle(fontFamily: "LexendDeca", fontSize: 14),
                  ),
                  subtitle: const Text(
                    "Automatically pick colors from current wallpaper",
                    style:
                        TextStyle(fontFamily: "LexendDeca-thin", fontSize: 12),
                  ),
                  trailing: Switch(
                      value: Provider.of<ThemeProvider>(context).isMaterial,
                      onChanged: (bool isTrue) {
                        isTrue
                            ? provider.materialTheme()
                            : provider.updateSeedColor(seedColor ?? Colors.purple);
                      }),
                ),
                ListTile(
                  leading: const Icon(
                    Broken.brush_1,
                    size: 28,
                  ),
                  title: const Text(
                    "Custom Coloring",
                    style: TextStyle(fontFamily: "LexendDeca", fontSize: 14),
                  ),
                  subtitle: const Text(
                    "Use custom color to change your vibe",
                    style:
                        TextStyle(fontFamily: "LexendDeca-thin", fontSize: 12),
                  ),
                  trailing: Switch(
                      value: !Provider.of<ThemeProvider>(context).isMaterial,
                      onChanged: (bool isTrue) {
                        log(isTrue.toString());
                        isTrue
                            ? provider.updateSeedColor(seedColor ?? Colors.purple)
                            : provider.materialTheme();
                      }),
                ),
                ListTile(
                  leading: const Icon(
                    Broken.paintbucket,
                    size: 28,
                  ),
                  title: const Text(
                    "Palette Color",
                    style: TextStyle(fontFamily: "LexendDeca", fontSize: 14),
                  ),
                  subtitle: const Text(
                    "Use custom color to change your vibe",
                    style:
                        TextStyle(fontFamily: "LexendDeca-thin", fontSize: 12),
                  ),
                  onTap: () {
                    paletteBox(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void paletteBox(BuildContext context) {
    String selectedPalette =
        Provider.of<ThemeProvider>(context, listen: false).varient;

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter dialogState) {
          return Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                    color: Colors.black
                        .withOpacity(0.0)), // Optional color overlay
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Dialog(
                  elevation: 20,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerLowest,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Palette Mode",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "LexendDeca",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: paletteList.length,
                            itemBuilder: (context, index) {
                              bool isSelected =
                                  paletteList[index] == selectedPalette;

                              return GestureDetector(
                                onTap: () {
                                  dialogState(() {
                                    selectedPalette = paletteList[index];
                                  });
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceBright,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Broken.main_component,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          paletteList[index],
                                          style: const TextStyle(
                                            fontFamily: "LexendDeca",
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CheckMark(
                                          strokeWidth: 2,
                                          activeColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          inactiveColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          duration:
                                              const Duration(milliseconds: 400),
                                          active: isSelected,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  elevation: WidgetStateProperty.all(0)),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(fontFamily: "LexendDeca"),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: WidgetStateProperty.all(0),
                                backgroundColor: WidgetStateProperty.all(
                                    Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer),
                              ),
                              onPressed: () {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .setPaletteColor(selectedPalette);
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                    fontFamily: "LexendDeca"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
