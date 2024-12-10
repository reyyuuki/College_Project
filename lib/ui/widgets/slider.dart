// ignore_for_file: must_be_immutable

import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:agarwal_school/provider/theme/theme_provider.dart';
import 'package:agarwal_school/ui/widgets/gradient_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSLider extends StatefulWidget {
  final Map<String, dynamic> data;
  final PageController controller;
  List<bool> isClickedList;
  CustomSLider(
      {super.key,
      required this.data,
      required this.controller,
      required this.isClickedList});

  @override
  State<CustomSLider> createState() => _SliderState();
}

class _SliderState extends State<CustomSLider> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context,listen: false);
    return Column(
      children: [
        const GradientHeader(name: "Our Campus"),
        SizedBox(
          height: 400,
          child: PageView.builder(
            controller: widget.controller,
            itemCount: widget.data['images'].length,
            itemBuilder: (context, index) {
              final item = widget.data['images'][index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 400,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: item['image'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[900]!,
                            highlightColor: Colors.grey[700]!,
                            child: Container(
                              color: Colors.grey[400],
                              height: 250,
                              width: double.infinity,
                            ),
                          ),
                          errorWidget: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.isClickedList[index] =
                                !widget.isClickedList[index];
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer
                                  .withOpacity(0.4),
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    color: widget.isClickedList[index]
                                        ? Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.6)
                                        : Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer
                                            .withOpacity(0.4))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: Icon(
                                shadows: !widget.isClickedList[index]
                                    ? [
                                        BoxShadow(
                                            blurRadius: 10,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary)
                                      ]
                                    : [],
                                widget.isClickedList[index]
                                    ? Icons.favorite
                                    : Broken.heart,
                                key:
                                    ValueKey<bool>(widget.isClickedList[index]),
                                color: widget.isClickedList[index]
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.primary,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 15 * provider.blurValue!,
                                    color:
                                        Theme.of(context).colorScheme.primary.withOpacity(provider.glowValue!),
                                    spreadRadius: 0,
                                    offset: const Offset(0, -1))
                              ],
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            item['title'],
                            style:  TextStyle(
                                fontFamily: "LexendDeca", color: Theme.of(context).colorScheme.surface),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                        ))
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        SmoothPageIndicator(
          controller: widget.controller,
          count: widget.data['images'].length,
          effect: ScrollingDotsEffect(
              activeDotColor: Theme.of(context).colorScheme.primary,
              dotColor: Colors.grey.shade700,
              dotHeight: 10,
              dotWidth: 10,
              spacing: 10,
              radius: 8,
              fixedCenter: true,
              activeStrokeWidth: 0,
              activeDotScale: 0),
        ),
      ],
    );
  }
}
