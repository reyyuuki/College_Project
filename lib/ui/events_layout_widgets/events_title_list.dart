import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:agarwal_school/screens/events/event_details.dart';
import 'package:flutter/material.dart';

class EventsTitleList extends StatelessWidget {
  const EventsTitleList({
    super.key,
    required this.data,
  });

  final Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(20)),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: data?['events'].length,
        itemBuilder: (context, index) {
          final event = data?['events'][index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 300),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0, 1);
                        const end = Offset.zero;
                        const curves = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curves));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return EventDetails(
                            link: event['link'],
                            image: event['image'],
                            title: event['title']);
                      }));
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 0)
                  ],
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.surfaceBright,
                    Theme.of(context).colorScheme.primary.withAlpha(90)
                  ]),
                  border: Border(
                      left: BorderSide(
                          width: 3,
                          color: Theme.of(context).colorScheme.primary))),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.4),
                              blurRadius: 5,
                            )
                          ]),
                      child: Icon(
                        Broken.attach_circle,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      event['title'],
                      style: const TextStyle(fontFamily: "LexendDeca"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
