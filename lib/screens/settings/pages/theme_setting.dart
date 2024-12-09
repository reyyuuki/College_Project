import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:agarwal_school/ui/theme_widgets/custom_color.dart';
import 'package:agarwal_school/ui/theme_widgets/theme_color.dart';
import 'package:agarwal_school/ui/theme_widgets/theme_modes.dart';
import 'package:flutter/material.dart';

class ThemeSetting extends StatefulWidget {
  const ThemeSetting({super.key});

  @override
  State<ThemeSetting> createState() => _ThemeSettingState();
}

class _ThemeSettingState extends State<ThemeSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
          forceMaterialTransparency: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Broken.arrow_left_2)),
          title: const Text(
            "Theme",
            style: TextStyle(fontFamily: "LexendDeca", fontSize: 18),
          )),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.transparent,
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
              Theme.of(context).colorScheme.primary.withOpacity(0.4),
              Theme.of(context).colorScheme.primary.withOpacity(0.6),
              Theme.of(context).colorScheme.primary.withOpacity(0.8)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          children: const [
            ThemeModes(),
            SizedBox(
              height: 20,
            ),
            ThemeColor(),
            SizedBox(height: 20,),
            CustomColor()
          ],
        ),
      ),
    );
  }
}
