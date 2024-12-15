import 'package:school_app/core/icons/icons_broken.dart';
import 'package:school_app/provider/theme/theme_provider.dart';
import 'package:school_app/ui/theme_widgets/theme_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeModes extends StatefulWidget {
  const ThemeModes({super.key});

  @override
  State<ThemeModes> createState() => _ThemeModesState();
}

class _ThemeModesState extends State<ThemeModes> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.6))
      ], borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: const ListTile(
              leading: Icon(Broken.brush),
              title: Text(
                "Theme Mode",
                style: TextStyle(
                  fontFamily: "LexendDeca",
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      provider.lightTheme();
                    },
                    child: ThemeTemplate(
                        color: Colors.white,
                        isBorder: provider.isLightMode,
                        name: "Light Mode")),
                GestureDetector(
                  onTap: () {
                    provider.darkTheme();
                  },
                  child: ThemeTemplate(
                      color: const Color.fromARGB(255, 31, 31, 31),
                      isBorder: provider.isDarkMode,
                      name: "Dark Mode"),
                ),
                GestureDetector(
                  onTap: () {
                    provider.oledTheme();
                  },
                  child: ThemeTemplate(
                      color: Colors.black,
                      isBorder: !provider.isDarkMode && !provider.isLightMode,
                      name: "Oled Mode"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
