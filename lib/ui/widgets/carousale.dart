import 'package:agarwal_school/ui/widgets/gradient_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Carousale extends StatelessWidget {
 final List<Map<String,String>> data;
  const Carousale({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GradientHeader(name: "Facilities"),
        ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: CarouselView(
                  itemExtent: MediaQuery.of(context).size.width,
                  shrinkExtent: 100,
                  itemSnapping: true,
                  children: List.generate(data.length, (index) {
                    final item = data[index];
                    return Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: item['image'] ?? "",
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
                        Container(
                          height: 140,
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.surfaceContainerHigh,
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(20)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                item['title'].toString(),
                                style: const TextStyle(
                                    fontFamily: "LexendDeca", fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                child: Text(
                                  item['description'].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.onSurface,
                                      fontFamily: "LexendDeca-thin"),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
      ],
    );
  }
}