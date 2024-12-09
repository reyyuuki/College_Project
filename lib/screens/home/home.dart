import 'package:agarwal_school/fallback_data/backup_data.dart';
import 'package:agarwal_school/ui/widgets/activities_card.dart';
import 'package:agarwal_school/ui/widgets/carousale.dart';
import 'package:agarwal_school/ui/widgets/figures.dart';
import 'package:agarwal_school/ui/widgets/info_card.dart';
import 'package:agarwal_school/ui/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:agarwal_school/data/Scrapper/_scrapper.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? data;
  final _controller = PageController();
  List<bool>? isClickedList;

  @override
  void initState() {
    super.initState();
    backup();
  }

  void backup() {
    setState(() {
      data = backupData;
      isClickedList = List.generate(backupData['images']!.length, (_) => false);
    });
    getData();
  }

  void getData() async {
    final response =  Provider.of<DataProvider>(context,listen: false).data;
    if (response != null) {
      setState(() {
        data = response;
        isClickedList = List.generate(response['images'].length, (_) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          CustomSLider(
              data: data!,
              controller: _controller,
              isClickedList: isClickedList!),
          const SizedBox(
            height: 20,
          ),
          const InfoCard(),
          const SizedBox(
            height: 20,
          ),
          Figures(data: data!['figures']),
          const SizedBox(height: 20,),
          Carousale(data: data!['facilities']),
          const SizedBox(height: 20,),
          const ActivitiesCard(),
        ],
      ),
    );
  }
}