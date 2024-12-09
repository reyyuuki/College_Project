import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:agarwal_school/data/Scrapper/_scrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDetails extends StatefulWidget {
  final String title;
  final String image;
  final String link;
  const AboutDetails(
      {super.key,
      required this.title,
      required this.image,
      required this.link});

  @override
  State<AboutDetails> createState() => _AboutDetailsState();
}

class _AboutDetailsState extends State<AboutDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        physics: const BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(10)),
                  child: Hero(
                      tag: widget.link,
                      child: CachedNetworkImage(
                        imageUrl: widget.image,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white.withOpacity(0.5),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        fontFamily: "LexendDeca",
                        fontSize: 16,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ))
            ],
          ),
          FutureBuilder<Map<String, String>>(
              future: Provider.of<DataProvider>(context).aboutData(widget.link),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 150,
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
                  if (data?['description'] != null) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10),
                          ], borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: data!['image']!,
                              filterQuality: FilterQuality.high,
                              height: 200,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[900]!,
                                highlightColor: Colors.grey[700]!,
                                child: Container(
                                  color: Colors.grey[400],
                                  height: 200,
                                ),
                              ),
                              errorWidget: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.6),
                                      blurRadius: 10)
                                ],
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                                border: Border.all(
                                    width: 1,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              data['description']!,
                              style: const TextStyle(
                                  fontFamily: "LexendDeca-thin"),
                            ))
                      ],
                    );
                  } else {
                    Future<void> urlLauncher() async {
                      if (!await launchUrl(Uri.parse(data!['link']!))) {
                        throw Exception('Could not launch ${data['link']}');
                      }
                    }

                    return Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.6),
                                      blurRadius: 10,
                                    )
                                  ]),
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: widget.image,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[900]!,
                                    highlightColor: Colors.grey[700]!,
                                    child: Container(
                                      color: Colors.grey[400],
                                      height: 200,
                                      width: double.infinity,
                                    ),
                                  ),
                                  errorWidget: (context, error, stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ),
                            ),
                            Positioned.fill(
                                child: Container(
                              margin: const EdgeInsets.all(20),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black.withOpacity(0.4),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 3, color: Colors.red),
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.4),
                                        blurRadius: 10,
                                      )
                                    ]),
                                child: IconButton(
                                    onPressed: () {
                                      urlLauncher();
                                    },
                                    icon: const Icon(
                                      Broken.play,
                                      color: Colors.white,
                                      size: 100,
                                    )),
                              ),
                            ))
                          ],
                        ),
                      ],
                    );
                  }
                }
              })
        ],
      ),
    );
  }
}
