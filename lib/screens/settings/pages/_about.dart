// ignore_for_file: non_constant_identifier_names

import 'package:school_app/core/icons/icons_broken.dart';
import 'package:school_app/provider/theme/theme_provider.dart';
import 'package:school_app/ui/widgets/glowing_logo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSettings extends StatelessWidget {
  const AboutSettings({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ThemeProvider>(context);
    double glow = provider.glowValue!;
    double blur = provider.blurValue!;
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
          "About",
          style: TextStyle(fontFamily: "LexendDeca", fontSize: 18),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        children: [
          Column(
            children: [
              const GlowingLogo(),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "LaidLaw",
                style: TextStyle(fontFamily: "LexendDeca", fontSize: 20),
              ),
              FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      final data = snapShot.data;
                      return Text(
                        "v${data!.version}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          fontStyle: FontStyle.italic,
                        ),
                      );
                    } else {
                      return const Text("Loading...");
                    }
                  }),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: Border.all(width: 1,color: Theme.of(context).colorScheme.primary),
              boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(glow), blurRadius: 10 * blur),
            ], borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              onTap: () {
                _launchURL("https://github.com/reyyuuki");
              },
              leading: profile_circle(context),
              title: const Text(
                "Irfan",
                style: TextStyle(fontFamily: "LexendDeca", fontSize: 16),
              ),
              subtitle: const Text(
                "Developer",
                style: TextStyle(
                    fontFamily: "LexendDeca-thin",
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
              trailing: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(glow),
                        blurRadius: 10 * blur)
                  ]),
                  child: Icon(
                    shadows: [
                      BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(glow),
                          blurRadius: 10)
                    ],
                    Ionicons.logo_github,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                list_tile(
                    width,
                    context,
                    Icon(
                      Ionicons.logo_github,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                      shadows: [
                        BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(glow),
                            blurRadius: 10 * blur)
                      ],
                    ),
                    "Github",
                    "Explore the code.",
                    "https://github.com/reyyuuki/Azyx"),
                const SizedBox(
                  height: 10,
                ),
                list_tile(
                    width,
                    context,
                    Icon(
                      Ionicons.logo_discord,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                      shadows: [
                        BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(glow),
                            blurRadius: 10 * blur)
                      ],
                    ),
                    "Discord",
                    "Chat and collaborate with community.",
                    "https://discord.com/channels/@me"),
                const SizedBox(
                  height: 10,
                ),
                list_tile(
                    width,
                    context,
                    Icon(
                      Icons.telegram,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                      shadows: [
                        BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(glow),
                            blurRadius: 10 * blur)
                      ],
                    ),
                    "Telegram",
                    "Stay updated and connect with others.",
                    "https://t.me/Azyxanime"),
                const SizedBox(
                  height: 10,
                ),
                list_tile(
                    width,
                    context,
                    Icon(
                      Ionicons.logo_reddit,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                      shadows: [
                        BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(glow),
                            blurRadius: 10 * blur)
                      ],
                    ),
                    "Reddit",
                    "Discuss features and share feedback.",
                    "https://www.reddit.com/?rdt=44738"),
              ],
            ),
          )
        ],
      ),
    );
  }

  GestureDetector list_tile(double width, BuildContext context, Icon icon,
      String name, String subTitle, String url) {
        final provider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width,
        decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: Border.all(width: 1,color: Theme.of(context).colorScheme.primary),
              boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(provider.glowValue!), blurRadius: 10 * provider.blurValue!),
            ], borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(boxShadow: [
                       BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(provider.glowValue!), blurRadius: 1 * provider.blurValue!)
                      ], borderRadius: BorderRadius.circular(50)),
                      child: icon),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontFamily: "LexendDeca"),
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(
                            fontFamily: "LexendDeca-thin",
                            fontSize: 12,
                            color: Colors.grey.shade500),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container profile_circle(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(100)),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: SizedBox(
          height: 45,
          width: 45,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl:
                    'https://avatars.githubusercontent.com/u/160479695?s=400&u=add067b9d010ce53b58df7d104c1eb606042e3c6&v=4',
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
