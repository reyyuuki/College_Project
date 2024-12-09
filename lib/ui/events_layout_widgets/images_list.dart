import 'package:agarwal_school/screens/events/event_details.dart';
import 'package:agarwal_school/ui/widgets/image_with_title.dart';
import 'package:flutter/material.dart';

class ImagesList extends StatelessWidget {
  const ImagesList({
    super.key,
    required this.data,
  });

  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final event = data[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetails(link: event['link'], image: event['image'], title: event['title'])));
            },
            child: ImageWithTitle(
              image: event['image'],
              title: event['title'],
              link: event['link'],
            ),
          );
        },
      );
  }
}
