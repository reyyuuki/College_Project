import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:agarwal_school/screens/settings/pages/theme_setting.dart';
import 'package:flutter/material.dart';

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
              ),),
          child: ListView(
            children: [
              settingTile(
                  context,
                  "Theme",
                  "Choose Vibe : Light, Dark, Dynamic",
                  const Icon(Broken.brush_2)),
              settingTile(context, "UI", "Customize Your UI: Vibrant, Sleek",
                  const Icon(Broken.brush_1)),
              settingTile(
                  context,
                  "Check for Update",
                  "Choose Vibe : Light, Dark, Dynamic",
                  const Icon(Broken.refresh_2)),
              settingTile(context, "About", "Discover More: About Us",
                  const Icon(Broken.information))
            ],
          )),
    );
  }

  ListTile settingTile(
      BuildContext context, String title, String subtitle, Icon icon) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1,0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                      position: offsetAnimation, child: child);
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const ThemeSetting();
                }));
      },
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
