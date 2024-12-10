import 'package:agarwal_school/provider/theme/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class GlowingLogo extends StatelessWidget {
  const GlowingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Container(
                      width: 120, 
                      height: 130, 
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, 
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(provider.glowValue!),
                            blurRadius: 40 * provider.blurValue!, 
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://laidlawschool.org/wp-content/themes/navin/assets/images/bg-logo.png",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[900]!,
                            highlightColor: Colors.grey[700]!,
                            child: Container(
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    );
  }
}