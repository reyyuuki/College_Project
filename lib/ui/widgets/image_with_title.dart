import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageWithTitle extends StatelessWidget {
  final String title;
  final String image;
  final String? link;
  const ImageWithTitle(
      {super.key, required this.image, required this.title, this.link});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 3))
      ]),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: link != null
                  ? Hero(
                      tag: link!,
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
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
                    )
                  : Hero(
                    tag: title,
                    child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[900]!,
                          highlightColor: Colors.grey[700]!,
                          child: Container(
                            color: Colors.grey[400],
                            height: 300,
                            width: double.infinity,
                          ),
                        ),
                        errorWidget: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                  ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: "LexendDeca-thin", fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
