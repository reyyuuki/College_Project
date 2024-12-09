import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:agarwal_school/data/Scrapper/_scrapper.dart';
import 'package:agarwal_school/ui/widgets/image_with_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

class EventDetails extends StatefulWidget {
  final String link;
  final String image;
  final String title;
  const EventDetails(
      {super.key,
      required this.link,
      required this.image,
      required this.title});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  List<String>? data;

  @override
  void initState() {
    super.initState();
  }

  Future<List<String>> getData(context) async {
    final response = await Provider.of<DataProvider>(context, listen: false)
        .scrapeEventDetails(widget.link);
    return response;
  }

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
          title: TextScroll(
            widget.title,
            mode: TextScrollMode.bouncing,
            velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
            delayBefore: const Duration(milliseconds: 0),
            pauseBetween: const Duration(milliseconds: 0),
            style: const TextStyle(fontFamily: "LexendDeca", fontSize: 16),
            textAlign: TextAlign.right,
            selectable: true,
          )),
      body: ListView(
        children: [
          ImageWithTitle(
            image: widget.image,
            title: widget.title,
            link: widget.link,
          ),
          FutureBuilder<List<String>>(
              future: getData(context),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ));
                } else if (snapShot.hasError) {
                  return Text("Error: ${snapShot.hasError}");
                } else if (!snapShot.hasData || snapShot.data!.isEmpty) {
                  return const SizedBox.shrink();
                } else {
                  final data = snapShot.data;
                  return Column(children: [
                    for (var image in data!)
                      widget.image != image
                          ? ImageWithTitle(image: image, title: widget.title)
                          : const SizedBox.shrink(),
                  ]);
                }
              })
        ],
      ),
    );
  }
}
