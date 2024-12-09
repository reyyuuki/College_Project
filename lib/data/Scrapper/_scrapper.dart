import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  Map<String, dynamic>? _data;
  Map<String, dynamic>? get data => _data;

  DataProvider() {
    homePageScrapper();
  }
  String baseUrl = "https://laidlawschool.org/";
  Future<dynamic> homePageScrapper() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final document = parse(response.body);
        final mainCarousale = document.querySelectorAll(
            '.swiper-container.white-move .swiper-wrapper div');
        final imageUrls = mainCarousale
            .map((element) {
              final style = element.attributes['style'];
              if (style != null && style.contains('url(')) {
                final startIndex = style.indexOf('url(') + 4;
                final endIndex = style.indexOf(')', startIndex);
                final title = element.querySelector("span")?.text.trim();
                return {
                  "image":
                      style.substring(startIndex, endIndex).replaceAll("'", ""),
                  "title":
                      title.toString().isNotEmpty ? title : "Events of School"
                };
              }
              return '';
            })
            .where((url) => url.toString().isNotEmpty)
            .toList();

        final figures = [];
        final figuresElement = document.querySelectorAll(
            ".row.row-cols-2.row-cols-md-5.row-cols-sm-3 div");
        if (figuresElement.isNotEmpty) {
          for (var figureElement in figuresElement) {
            final number =
                figureElement.querySelector("h2")?.attributes['data-to'];
            final title = figureElement.querySelector("span")?.text.trim();
            figures.add({"figure": "$number+", "title": title});
          }
        }

        final notices = [];
        final noticeElement = document.querySelectorAll(".ml-2.mr-2 div");
        if (noticeElement.isNotEmpty) {
          for (var item in noticeElement) {
            final link = item.querySelector("a")?.attributes['href'];
            final title = item.querySelector("a")?.text.trim();
            if (link != null && title != null) {
              notices.add({"link": link, "title": title});
            }
          }
        }

        final Set<Map<String, String>> uniqueEvents = {};
        document
            .querySelectorAll(".swiper-simple-arrow-style-1 div")
            .map((item) {
          item.querySelectorAll("div div").map((img) {
            final image = img.querySelector("a img")?.attributes['data-src'];
            final link = img.querySelector("a")?.attributes['href'];
            final title = item
                .querySelector(".post-details .text-extra-dark-gray")!
                .text
                .trim();
            if (image != null && link != null && title.isNotEmpty) {
              uniqueEvents.add({"image": image, "link": link, "title": title});
            }
          }).toList();
        }).toList();
        List<Map<String, String>> events = uniqueEvents.toList();
        final activities = document
            .querySelectorAll("section.padding-4-rem-top > div div div")
            .map((item) {
          final image = item.querySelector("a img")?.attributes['data-src'];
          final link = item.querySelector("a")?.attributes['href'];
          if (image != null && link != null) {
            return ({"image": image, "link": link});
          }
        }).toList();

        final Set<Map<String, String>> uniqueFacilities = {};
        document
            .querySelectorAll(".sm-h-450px .swiper-wrapper div")
            .map((item) {
          final style = item.attributes['style'];
          String? image;
          if (style != null && style.contains('url(')) {
            final startIndex = style.indexOf('url(') + 4;
            final endIndex = style.indexOf(')', startIndex);
            image = style.substring(startIndex, endIndex).replaceAll("'", "");
          }
          final link = item.querySelector("div div h6 a")?.attributes['href'];
          final title = item.querySelector("div div h6 a")?.text.trim();
          final description = item.querySelector("div div p")?.text.trim();

          if (image != null &&
              link != null &&
              title != null &&
              description != null) {
            final facility = {
              "image": image,
              "link": link,
              "title": title,
              "description": description
            };

            uniqueFacilities.add(facility);
          }
        }).toList();

        final facilitiesList = uniqueFacilities.toList();
        _data = {
          "events": events,
          "notices": notices,
          "figures": figures,
          "images": imageUrls,
          "activities": activities,
          "facilities": facilitiesList,
        };
      }
    } catch (e) {
      log("error while scrapping home page: $e");
    }
    notifyListeners();
  }

  Future<List<String>> scrapeEventDetails(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = parse(response.body);
        List<String> images = [];
        document.querySelectorAll(".gallery.clearfix.gllr_grid div").map((row) {
          return row.querySelectorAll("div").map((img) {
            final image = img.querySelector("p a img")?.attributes['data-src'];
            if (image != null && image.isNotEmpty) {
              images.add(image);
            }
          }).toList();
        }).toList();
        log(images.toString());
        return images;
      }
    } catch (e) {
      log('error while in scrapping: $e');
    }
    notifyListeners();
    return [];
  }

  Future<Map<String, String>> aboutData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = parse(response.body);
        String image = '';
        final element = document
            .querySelector("img.border-radius-6px")
            ?.attributes['data-src'];
        if (element != null) {
          image = element;
          final description = document
              .querySelectorAll(".col-xl-8 p")
              .map((item) => item.text.trim())
              .join("");
          log(image);
          return {"image": image, "description": description};
        } else {
          log("come");
          final link =
              document.querySelector(".su-youtube iframe")?.attributes['data-src'] ??
                  "";
          log(link.toString());
          return {"image": link, "link": link};
        }
      }
    } catch (e, stackTrace) {
      log("error while fetching: $e", stackTrace: stackTrace);
    }
    return {};
  }
}
