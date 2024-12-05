import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:agarwal_school/data/Scrapper/home_page_scrapper.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  // List<Map<String, String>> schoolInfo = [
  //   {'heading': 'Academic Excellence', 'description': 'Agrawal Public School focuses on delivering strong academic results through a comprehensive curriculum.'},
  //   {'heading': 'Co-curricular Activities', 'description': 'The school offers a variety of extracurricular activities to help students develop creativity and confidence.'},
  //   {'heading': 'Modern Infrastructure', 'description': 'Agrawal Public School is equipped with state-of-the-art facilities, including advanced classrooms, labs, and sports areas.'},
  // ];

  void getData() async {
    final response = await Scrapper().homePageScrapper();
    if (response != null) {
      setState(() {
        data = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Animate(
            effects: [FadeEffect(), ScaleEffect()],
            child: const Text("Our Campus",textAlign: TextAlign.center,style: TextStyle(fontFamily: "LexendDeca",fontSize: 30),),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: CarouselView(
              itemExtent: MediaQuery.of(context).size.width,
              shrinkExtent: 100,
              itemSnapping: true,
              children: List.generate(data!['images'].length, (index) {
                final item = data!['images'][index];
                return ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: item['image'],
                    fit: BoxFit.cover,
                     placeholder: (context, url) =>
                                Shimmer.fromColors(
                              baseColor: Colors.grey[900]!,
                              highlightColor: Colors.grey[700]!,
                              child: Container(
                                color: Colors.grey[400],
                                height: 250,
                                width: double.infinity,
                              ),
                            ),
                    errorWidget: (context, error, stackTrace) {
                      return const Icon(Broken.archive_1);
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
