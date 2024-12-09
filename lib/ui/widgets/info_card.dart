import 'package:agarwal_school/ui/widgets/glowing_logo.dart';
import 'package:agarwal_school/ui/widgets/gradient_header.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GradientHeader(name: "Laidlaw Insights"),
        Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: Border.all(
                    width: 1, color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                const GlowingLogo(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "The Laidlaw MemorialSchool & Jr. College",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: "LexendDeca",
                      fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "The Laidlaw Memorial School of St. George's Homes, Ketti was founded in 1914 by the late Rev. John Breeden, to provide a home and education for children of the Protestant European and Anglo-Indian communities. It was generously endowed by late Sir Robert Laidlaw. The institution started its life in Kodaikanal but moved to Ketti, its present home, in 1922.",
                  style: TextStyle(fontFamily: "LexendDeca-thin"),
                  textAlign: TextAlign.center,
                )
              ],
            )),
      ],
    );
  }
}
