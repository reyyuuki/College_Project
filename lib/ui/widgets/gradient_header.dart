import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:flutter/material.dart';

class GradientHeader extends StatelessWidget {
  final String name;
  const GradientHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
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
          Icon(
            Broken.star,
            color: Theme.of(context).colorScheme.primary,
            size: 30,
            shadows: [
              BoxShadow(
                blurRadius: 10,
                color: Theme.of(context).colorScheme.primary,
              )
            ],
          )
        ],
      ),
    );
  }
}
