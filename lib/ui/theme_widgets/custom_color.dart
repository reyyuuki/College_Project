import 'package:school_app/core/icons/icons_broken.dart';
import 'package:school_app/provider/theme/theme_provider.dart';
import 'package:school_app/ui/theme_widgets/custom_color_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomColor extends StatefulWidget {
  const CustomColor({super.key});

  @override
  State<CustomColor> createState() => _ThemeModesState();
}

class _ThemeModesState extends State<CustomColor> {
  final Map<String, Color> colorMap = {
    "Green": Colors.green,
    "Purple": Colors.purple,
    "Pink": Colors.pink,
    "Blue": Colors.blue,
    "Orange": Colors.orange,
    "Yellow": Colors.yellow,
    "Cyan": Colors.cyan,
    "DeepOrange": Colors.deepOrange,
    "Indigo": Colors.indigo,
  };
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    final List<String> color = colorMap.keys.toList();
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
              leading: Icon(Broken.color_swatch),
              title: Text(
                "Custom Color",
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
            child: SizedBox(
              height: 190,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: colorMap.length,
                itemBuilder: (context, index) {
                  String colorName = color[index];
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          provider.updateSeedColor(colorMap[colorName]!);
                        });
                      },
                      child: CustomColorTemplate(
                          color: colorMap[colorName]!,
                          isBorder: colorMap[colorName]?.value ==
                              provider.seedColor.value,
                          name: colorName));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
