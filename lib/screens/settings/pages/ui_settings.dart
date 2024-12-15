// ignore_for_file: non_constant_identifier_names

import 'package:school_app/core/icons/icons_broken.dart';
import 'package:school_app/provider/theme/theme_provider.dart';
import 'package:school_app/ui/widgets/slider_bar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class UiSettings extends StatefulWidget {
  const UiSettings({super.key});

  @override
  State<UiSettings> createState() => _UiSettingsState();
}

class _UiSettingsState extends State<UiSettings> {
  double? blur;
  double? glow;
  @override
  void initState() {
    super.initState();
    blur = Provider.of<ThemeProvider>(context, listen: false).blurValue;
    glow = Provider.of<ThemeProvider>(context, listen: false).glowValue;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          "UI Settings",
          style: TextStyle(fontFamily: "LexendDeca", fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Broken.arrow_left_2)),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
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
        )),
        child: ListView(
          children: [
            glow_setting(context, provider),
            const SizedBox(
              height: 40,
            ),
            blur_setting(context, provider)
          ],
        ),
      ),
    );
  }

  Container blur_setting(BuildContext context, ThemeProvider provider) {
    return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.6))
            ], borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20))),
                  child: const ListTile(
                    leading: Icon(Broken.blur),
                    title: Text(
                      "Color Blur",
                      style: TextStyle(
                        fontFamily: "LexendDeca",
                      ),
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerLowest,
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20))),
                    child: Column(
                      children: [
                        const ListTile(
                          leading: Icon(Ionicons.color_wand),
                          title: Text(
                            "Blur Multiplier",
                            style: TextStyle(fontFamily: "LexendDeca"),
                          ),
                          subtitle: Text(
                            "Adjust the blur for your vibe",
                            style: TextStyle(
                                fontSize: 12, fontFamily: "LexendDeca-thin"),
                          ),
                        ),
                        Row(
                          children: [
                             Text(
                              blur!.toStringAsFixed(1),
                              style: const TextStyle(fontFamily: "LexendDeca"),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.6 * glow!),
                                      blurRadius: 5 * blur!)
                                ]),
                                child: CustomSlider(
                                    onChanged: (double newValue) {
                                      setState(() {
                                        blur = newValue;
                                        provider.bluerMultiplier(newValue);
                                      });
                                    },
                                    divisions: 10,
                                    max: 5.0,
                                    min: 1.0,
                                    value: double.parse(
                                        blur!.toStringAsFixed(1))),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            const Text(
                              "5.0",
                              style: TextStyle(fontFamily: "LexendDeca"),
                            )
                          ],
                        )
                      ],
                    )),
              ],
            ),
          );
  }

  Container glow_setting(BuildContext context, ThemeProvider provider) {
    return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.6))
            ], borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20))),
                  child: const ListTile(
                    leading: Icon(Broken.colorfilter),
                    title: Text(
                      "Color Glow",
                      style: TextStyle(
                        fontFamily: "LexendDeca",
                      ),
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerLowest,
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20))),
                    child: Column(
                      children: [
                        const ListTile(
                          leading: Icon(Ionicons.color_fill),
                          title: Text(
                            "Glow Multiplier",
                            style: TextStyle(fontFamily: "LexendDeca"),
                          ),
                          subtitle: Text(
                            "Adjust the glow for your vibe",
                            style: TextStyle(
                                fontSize: 12, fontFamily: "LexendDeca-thin"),
                          ),
                        ),
                        Row(
                          children: [
                             Text(
                              glow!.toStringAsFixed(1),
                              style: const TextStyle(fontFamily: "LexendDeca"),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(glow!),
                                      blurRadius: 5 * blur!)
                                ]),
                                child: CustomSlider(
                                    onChanged: (double newValue) {
                                      setState(() {
                                        glow = newValue;
                                        provider.glowMultiplier(newValue);
                                      });
                                    },
                                    divisions: 10,
                                    max: 1.0,
                                    min: 0.0,
                                    value: double.parse(
                                        glow!.toStringAsFixed(1))),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            const Text(
                              "1.0",
                              style: TextStyle(fontFamily: "LexendDeca"),
                            )
                          ],
                        )
                      ],
                    )),
              ],
            ),
          );
  }
}
