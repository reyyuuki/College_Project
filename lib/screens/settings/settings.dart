import 'package:school_app/core/icons/icons_broken.dart';
import 'package:school_app/provider/theme/theme_provider.dart';
import 'package:school_app/screens/settings/pages/_about.dart';
import 'package:school_app/screens/settings/pages/theme_setting.dart';
import 'package:school_app/screens/settings/pages/ui_settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
            "Settings",
            style: TextStyle(fontFamily: "LexendDeca", fontSize: 18),
          )),
      body: Container(
          width: MediaQuery.of(context).size.width,
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
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1, 0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                                position: offsetAnimation, child: child);
                          },
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const ThemeSetting();
                          }));
                },
                child: settingTile(
                    context,
                    "Theme",
                    "Choose Vibe : Light, Dark, Dynamic",
                    const Icon(Broken.brush_2)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1, 0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                                position: offsetAnimation, child: child);
                          },
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const UiSettings();
                          }));
                },
                child: settingTile(
                    context,
                    "UI",
                    "Customize Your UI: Vibrant, Sleek",
                    const Icon(Broken.brush_1)),
              ),
              GestureDetector(
                onTap: () {
                  openDialogBox(context);
                },
                child: settingTile(context, "Clear Cache",
                    "Reset All Cached Settings", const Icon(Broken.trash)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1, 0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                                position: offsetAnimation, child: child);
                          },
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const AboutSettings();
                          }));
                },
                child: settingTile(context, "About", "Discover More: About Us",
                    const Icon(Broken.information)),
              ),
            ],
          )),
    );
  }

  void openDialogBox(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              height: 125,
              child: Column(
                children: [
                  const Text("Want to reset all the settings",style: TextStyle(
                    fontFamily: "LexendDeca",
                    fontSize: 16
                  ),),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onSurface),
                              elevation: WidgetStateProperty.all(0)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Theme.of(context).colorScheme.surface,fontFamily: "LexendDeca"),
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context).colorScheme.primary),
                              elevation: WidgetStateProperty.all(0)),
                          onPressed: () {
                            Navigator.pop(context);
                            Provider.of<ThemeProvider>(context,listen: false).resetSetting();
                          },
                          child: Text("Reset",style: TextStyle(color: Theme.of(context).colorScheme.surface,fontFamily: "LexendDeca"),))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  ListTile settingTile(
      BuildContext context, String title, String subtitle, Icon icon) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(fontFamily: "LexendDeca"),
      ),
      trailing: const Icon(Broken.arrow_right_3),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontFamily: "LexendDeca-thin", fontSize: 12),
      ),
    );
  }
}
