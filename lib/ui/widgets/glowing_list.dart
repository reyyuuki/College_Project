import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:agarwal_school/fallback_data/backup_data.dart';
import 'package:agarwal_school/screens/about/about_details.dart';
import 'package:flutter/material.dart';

class GlowingList extends StatelessWidget {
  const GlowingList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.surfaceContainerLowest,
            border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(20)),
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: backupData['aboutUs']?.length,
          itemBuilder: (context, index) {
            final item = backupData['aboutUs']?[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration:
                            const Duration(milliseconds: 300),
                        transitionsBuilder: (context, animation,
                            secondaryAnimation, child) {
                          const begin = Offset(0, 1);
                          const end = Offset.zero;
                          const curves = Curves.ease;
    
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curves));
                          var offsetAnimation =
                              animation.drive(tween);
    
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        pageBuilder:
                            (context, animation, secondaryAnimation) {
                          return AboutDetails(
                              link: item['link']!,
                              image: item['image'] ?? "",
                              title: item['title']!);
                        }));
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceBright,
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
                      Theme.of(context)
                          .colorScheme
                          .primary
                          .withAlpha(90)
                    ]),
                    border: Border(
                        left: BorderSide(
                            width: 3,
                            color: Theme.of(context)
                                .colorScheme
                                .primary))),
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
                          color:
                              Theme.of(context).colorScheme.primary,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      item!['title']!,
                      style:
                          const TextStyle(fontFamily: "LexendDeca"),
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