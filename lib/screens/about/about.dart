import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:agarwal_school/fallback_data/backup_data.dart';
import 'package:agarwal_school/provider/theme/theme_provider.dart';
import 'package:agarwal_school/ui/about_layouts.dart/about_image_list.dart';
import 'package:agarwal_school/ui/widgets/glowing_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool isImage = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    double blur = provider.blurValue!;
    double glow = provider.glowValue!;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Academic Us",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "LexendDeca",
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primaryFixedDim,
                          Theme.of(context).colorScheme.onSecondaryContainer,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isImage = !isImage;
                    });
                  },
                  icon: Icon(
                    !isImage ? Broken.menu_1 : Broken.image,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                    shadows: [
                      BoxShadow(
                        blurRadius: 10 * blur,
                        color: Theme.of(context).colorScheme.primary.withOpacity(glow),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          !isImage
              ? const GlowingList()
              : AboutImageList(data: backupData['aboutUs']!)
        ],
      ),
    );
  }
}


