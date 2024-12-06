import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:agarwal_school/data/Scrapper/home_page_scrapper.dart';
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
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: item['image'],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[900]!,
                      highlightColor: Colors.grey[700]!,
                      child: Container(
                        color: Colors.grey[400],
                        height: 250,
                        width: double.infinity,
                      ),
                    ),
                    errorWidget: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: Border.all(
                    width: 1, color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(20)),
            child: const Text(
              "Infrastructure & Facilities",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "LexendDeca", fontSize: 30),
            ),
          ),
          const SizedBox(height: 10,),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: CarouselView(
              itemExtent: MediaQuery.of(context).size.width,
              shrinkExtent: 100,
              itemSnapping: true,
              children: List.generate(data!['facilities'].length, (index) {
                final item = data!['facilities'][index];
                return Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: item['image'] ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[900]!,
                            highlightColor: Colors.grey[700]!,
                            child: Container(
                              color: Colors.grey[400],
                              height: 250,
                              width: double.infinity,
                            ),
                          ),
                          errorWidget: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 140,
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(item['title'], style: const TextStyle(fontFamily: "LexendDeca",fontSize: 18),),
                          const SizedBox(height: 10,),
                          Text(item['description'])
                        ],
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
