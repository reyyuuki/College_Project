import 'dart:developer';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class Scrapper {
  String baseUrl = "https://apsraipur.in/";
  Future<dynamic> homePageScrapper() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final images = [];
        final document = parse(response.body);
        final mainCarousale =
            document.querySelectorAll('.carousel-inner .item');
        if (mainCarousale.isNotEmpty) {
          for (var item in mainCarousale) {
            final image = item.querySelector("img")?.attributes['src'] ?? '';
            images.add({"image": image});
          }
        }
        String thumbnail =
            "https://apsraipur.in/wp-content/uploads/2023/01/APS-SN-VIDEO-IMG.jpg";
        final thumbNailLink = document
            .querySelector(".container .row .col-md-12 div a")
            ?.attributes['href'];

        final facilitiesImages = [];
        final facilitiesElements = document
            .querySelectorAll("#swiper-wrapper-0a5f524ef8aa919d .swiper-slide");
        if (facilitiesElements.isNotEmpty) {
          for (var facilitiesElement in facilitiesElements) {
            final image = facilitiesElement
                .querySelector(".team-image img")
                ?.attributes['src'];
            final title = facilitiesElement
                .querySelector("figcaption div div")
                ?.text
                .trim();
            facilitiesImages.add({"image": image, "title": title});
          }
        }
        log(facilitiesImages.toString());
        return {
          "thumbnail": thumbnail,
          "videoUrl": thumbNailLink,
          "facilities": facilitiesImages,
          "images": images,
        };
      }
    } catch (e) {
      log("error while scrapping home page: $e");
    }
  }

  Future<dynamic> facilities() async {
    try {
      const url = "https://apsraipur.in/computer-lab/";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = parse(response.body);
        final description =
            document.querySelector(".pagetext > p:nth-child(1)")?.text.trim();
        final imageElements =
            document.querySelectorAll(".gallery div").map((row) {
          final imagesRow = row.querySelectorAll("div").map((img) {
            final image =
                img.querySelector("p a img")?.attributes['src'].toString();
            log(image.toString());
            return {"image": image ?? ""};
          }).toList();
          return {"imageRow": imagesRow};
        }).toList();
        log(description.toString());
        return {"images": imageElements, "description": description};
      }
    } catch (e) {
      log("error when feching section: $e");
    }
  }

  Map<String, String> aboutUs() {
    const description = '''
According to a common saying, “God gives every bird its food, but he doesn’t toss it in its nest,” he provides, but one still needs to put forth effort. He doesn’t uncover the goodness that the earth holds; instead, he obstructs our path and provides the tools we need to find it for ourselves.

As one of the best schools in the area, it offers a friendly and supportive environment for studying and fostering the skills of young people. It has come a long way since it first started. The building is well-maintained and very beautiful. It has modern facilities like ultra-modern lift, library, computer lab, etc.

Agarwal Public School Shankar Nagar Raipur offers high-quality, up-to-date education with a focus on culture, instilling values, raising environmental consciousness, adventure-based learning, and physical education; an education that is value-based, an education that both gives roots and wings. Our motto is “Quality Education for Common Man.”

The parent community and the Agarwal Public School fraternity have worked together to promote and nurture child development, which will serve as the cornerstone for benchmark achievement.

In its quest for greatness, Agarwal Public School is dedicated to upholding high standards while keeping attentive to concerns pertaining to human resources, including their upbringing, grooming, enrichment, and growth.

We want to create: Successful Learners, Confident Individuals, and Responsible Citizens.
''';
    return {
      "description": description,
      "image":
          "https://apsraipur.in//wp-content/uploads/2023/01/sankar-nagar-img.jpg"
    };
  }
}
