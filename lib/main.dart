import 'package:agarwal_school/data/Scrapper/home_page_scrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.tab)),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network("https://apsraipur.in/wp-content/uploads/2023/01/LOGO-APS-SN.jpg", fit: BoxFit.cover,),
                ),
              ),
            )
          ],
        ),
        body: ListView(
          children: [

        ],)
      ),
    );
  }
}
