import 'dart:developer';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class Scrapper {
  String baseUrl = "https://laidlawschool.org/";
  Future<dynamic> homePageScrapper() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final document = parse(response.body);
        final mainCarousale =
            document.querySelectorAll('.swiper-container.white-move .swiper-wrapper div');
         final imageUrls = mainCarousale.map((element) {
        final style = element.attributes['style'];
        if (style != null && style.contains('url(')) {
          final startIndex = style.indexOf('url(') + 4;
          final endIndex = style.indexOf(')', startIndex);
          return {"image": style.substring(startIndex, endIndex).replaceAll("'", "")};
        }
        return '';
      }).where((url) => url.toString().isNotEmpty).toList();

        // String thumbnail =
        //     "https://apsraipur.in/wp-content/uploads/2023/01/APS-SN-VIDEO-IMG.jpg";
        // final thumbNailLink = document
        //     .querySelector(".container .row .col-md-12 div a")
        //     ?.attributes['href'];

        final figures = [];
        final figuresElement = document
            .querySelectorAll(".row.row-cols-2.row-cols-md-5.row-cols-sm-3 div");
        if (figuresElement.isNotEmpty) {
          for (var figureElement in figuresElement) {
            final number = figureElement
                .querySelector("h2")?.attributes['data-to'];
            final title = figureElement
                .querySelector("span")
                ?.text
                .trim();
            figures.add({"figure": number, "title": title});
          }
        }
        
        final notices = [];
        final noticeElement = document
            .querySelectorAll(".ml-2.mr-2 div");
        if (noticeElement.isNotEmpty) {
          for (var item in noticeElement) {
            final link = item
                .querySelector("a")?.attributes['href'];
            final title = item
                .querySelector("a")
                ?.text
                .trim();
                if(link != null && title != null){
                  notices.add({"link": link, "title": title});
                }   
          }
        }

        final events = [];
        document
            .querySelectorAll(".swiper-simple-arrow-style-1 div").map((item){
              item.querySelectorAll("div div").map((img){
                final image = img.querySelector("a img")?.attributes['data-src'];
                final link = img.querySelector("a")?.attributes['href'];
                if(image != null && link != null){
                events.add({"image": image, "link": link});
                }
              }).toList();
            }).toList();

          final activities = document.querySelectorAll("section.padding-4-rem-top > div div div").map((item){
              final image = item.querySelector("a img")?.attributes['data-src'];
                final link = item.querySelector("a")?.attributes['href'];
                if(image != null && link != null){
                return({"image": image, "link": link});
                }
          }).toList();

          log(imageUrls.toString());
        return {
          "events":events,
          "notices": notices,
          "facilities": figures,
          "images": imageUrls,
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
