import 'package:agarwal_school/ui/widgets/gradient_header.dart';
import 'package:flutter/material.dart';

class Figures extends StatelessWidget {
  final List<dynamic> data;
  const Figures({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const GradientHeader(name: "Facts & Figures"),
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              border: Border.all(
                  width: 1, color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(20)),
          child: Wrap(
            spacing: 5,
              alignment: WrapAlignment.center,
              children: data.map<Widget>((item) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                  padding: const EdgeInsets.only(left:10,right: 10, bottom: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color:
                                    Theme.of(context).colorScheme.primary,
                                spreadRadius: 0),
                          ],
                        ),
                        child: Text(item['figure'],
                            style: TextStyle(
                              fontFamily: "LexendDeca",
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.surface,
                            )),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        item['title'],
                        style: const TextStyle(
                            fontFamily: "LexendDeca", fontSize: 14),
                      )
                    ],
                  ),
                );
              }).toList()),
        ),
      ],
    );
  }
}
