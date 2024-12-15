// lib/widgets/staggered_grid_widget.dart

import 'package:school_app/screens/events/event_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class StaggeredGrid extends StatelessWidget {
  final Map<String, dynamic>? data;

  const StaggeredGrid({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 4,
      itemCount: data?['events'].length,
      staggeredTileBuilder: (index) {
        if (index % 2 == 0) {
          return const StaggeredTile.count(2, 3);
        } else {
          return const StaggeredTile.count(2, 2);
        }
      },
      itemBuilder: (context, index) {
        final item = data?['events'][index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventDetails(
                        link: item['link'],
                        image: item['image'],
                        title: item['title'] ?? "N/A")));
          },
          child: Stack(
            children: [
              Container(
                height: index % 2 == 0 ? 300 : 200,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(0, 4))
                    ]),
                clipBehavior: Clip.antiAlias,
                child: Hero(
                  tag: item['link'],
                  child: CachedNetworkImage(
                    imageUrl: data?['events'][index]['image'] ?? '',
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[900]!,
                                highlightColor: Colors.grey[700]!,
                                child: Container(
                                  color: Colors.grey[400],
                                  height: 250,
                                  width: double.infinity,
                                ),
                              ),
                  ),
                ),
              ),
              Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.onPrimaryFixedVariant.withOpacity(0.5)
                          )
                        ]
                      ),
                      child: Text(item['title'],overflow: TextOverflow.ellipsis,maxLines: 2, textAlign: TextAlign.center,style: const TextStyle(color: Colors.white,fontFamily: "LexendDeca"),)))
            ],
          ),
        );
      },
    );
  }
}
