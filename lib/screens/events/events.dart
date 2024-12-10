import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:agarwal_school/data/Scrapper/_scrapper.dart';
import 'package:agarwal_school/fallback_data/backup_data.dart';
import 'package:agarwal_school/provider/theme/theme_provider.dart';
import 'package:agarwal_school/ui/events_layout_widgets/events_title_list.dart';
import 'package:agarwal_school/ui/events_layout_widgets/images_list.dart';
import 'package:agarwal_school/ui/events_layout_widgets/staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

enum Layout { grid, imageWithTitle, list }

class _EventsState extends State<Events> {
  Map<String, dynamic>? data;
  Layout selectedLayout = Layout.imageWithTitle;

  @override
  void initState() {
    super.initState();
    backup();
  }

  void backup() {
    setState(() {
      data = backupData;
    });
  }

  void getData() {
    setState(() {
      data = Provider.of<DataProvider>(context, listen: false).data;
    });
  }

  void changeLayout() {
    setState(() {
      selectedLayout = Layout.values[
          (Layout.values.indexOf(selectedLayout) + 1) % Layout.values.length];
    });
  }

  IconData geticon(Layout name){
    switch (name){
      case Layout.grid:
        return Icons.grid_view;
      case Layout.imageWithTitle:
        return Broken.image;
      case Layout.list:
        return Broken.menu_1;
    }
  }

Widget getLayout(Layout name){
    switch (name){
      case Layout.grid:
        return StaggeredGrid(data: data,);
      case Layout.imageWithTitle:
        return ImagesList(data: data?['events']);
      case Layout.list:
        return EventsTitleList(data: data);
    }
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    double blur = provider.blurValue!;
    double glow = provider.glowValue!;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Academic Events",
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
                      changeLayout();
                    },
                    icon: Icon(
                      geticon(selectedLayout),
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
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(child: getLayout(selectedLayout)),
          ],
        ));
  }
}
