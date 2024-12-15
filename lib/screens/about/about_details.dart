import 'package:school_app/core/icons/icons_broken.dart';
import 'package:school_app/fallback_data/backup_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:text_scroll/text_scroll.dart';

class AboutDetails extends StatefulWidget {
  final String title;
  final String image;
  const AboutDetails({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  State<AboutDetails> createState() => _AboutDetailsState();
}

class _AboutDetailsState extends State<AboutDetails> {
  @override
  Widget build(BuildContext context) {
    final data = aboutDetails[widget.title];
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
        padding: const EdgeInsets.all(10),
        children: [
          Container(
              margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10),
            ], borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: widget.title,
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
                      width: 150,
                    ),
                  ),
                  errorWidget: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
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
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                data['description']!,
                style: const TextStyle(fontFamily: "LexendDeca-thin"),
              ))
        ],
      ),
    );
  }
}
