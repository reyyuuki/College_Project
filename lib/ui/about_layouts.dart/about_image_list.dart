import 'package:school_app/screens/about/about_details.dart';
import 'package:school_app/ui/widgets/image_with_title.dart';
import 'package:flutter/material.dart';

class AboutImageList extends StatelessWidget {
  const AboutImageList({
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutDetails(image: event['image'], title: event['title'])));
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
