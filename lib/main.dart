// ignore_for_file: use_build_context_synchronously

import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:agarwal_school/data/Scrapper/_scrapper.dart';
import 'package:agarwal_school/provider/theme/theme_provider.dart';
import 'package:agarwal_school/screens/about/about.dart';
import 'package:agarwal_school/screens/enquiry/enquiry.dart';
import 'package:agarwal_school/screens/events/events.dart';
import 'package:agarwal_school/screens/home/home.dart';
import 'package:agarwal_school/screens/settings/settings.dart';
import 'package:agarwal_school/ui/widgets/glowing_logo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("app-data");
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => DataProvider())
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      color: Theme.of(context).colorScheme.surface,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  final List _pages = [
    const HomePage(),
    const Events(),
    const Enquiry(),
    const About(),
  ];

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Broken.home;
      case 1:
        return Broken.activity;
      case 2:
        return Broken.security_safe;
      case 3:
        return Broken.information;
      default:
        return Icons.home;
    }
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Events";
      case 2:
        return "Enquiry";
      case 3:
        return "About";
      default:
        return "Home";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scffoldKey,
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.surface,
          width: 180,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      height: 190,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: const DrawerHeader(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        child: Center(
                          child: GlowingLogo(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...List.generate(
                      _pages.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          Future.delayed(const Duration(milliseconds: 100), () {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          height: 45,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: _selectedIndex == index
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: _selectedIndex == index
                                ? [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.6),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 10,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 2))
                                  ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getIconForIndex(index),
                                color: _selectedIndex == index
                                    ? Theme.of(context).colorScheme.surface
                                    : Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _getLabelForIndex(index),
                                style: TextStyle(
                                  fontFamily: "LexendDeca",
                                  color: _selectedIndex == index
                                      ? Theme.of(context).colorScheme.surface
                                      : Theme.of(context)
                                          .colorScheme
                                          .inverseSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 40,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 15,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface
                                    .withOpacity(0.6),
                                spreadRadius: 1,
                                offset: const Offset(0, 2))
                          ]),
                      child: CustomSlidingSegmentedControl(
                          initialValue:
                              Provider.of<ThemeProvider>(context,listen: false).isLightMode
                                  ? 2
                                  : 1,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          thumbDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceBright
                                .withOpacity(0.8),
                          ),
                          fixedWidth: 74,
                          children: const {
                            1: Icon(Broken.moon),
                            2: Icon(Broken.sun_1)
                          },
                          onValueChanged: (v) {
                            v == 1
                                ? Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .darkTheme()
                                : Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .lightTheme();
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(width: 1))),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                          Future.delayed(const Duration(milliseconds: 50), () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 400),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const Settings();
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                      position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          });
                        });
                      },
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.6),
                                blurRadius: 20,
                                spreadRadius: 0,
                                offset: const Offset(0, 2))
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Broken.setting_2,
                                color: Theme.of(context).colorScheme.surface),
                            const SizedBox(width: 10),
                            Text(
                              "Settings",
                              style: TextStyle(
                                  fontFamily: "LexendDeca",
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "THE LAIDLAW MEMORIAL",
                style: TextStyle(fontSize: 14, fontFamily: "LexendDeca"),
              ),
              Text(
                "School & Junior College, Ketti",
                style: TextStyle(fontSize: 12, fontFamily: "LexendDeca-thin"),
              ),
            ],
          ),
          forceMaterialTransparency: true,
          leading: IconButton(
              onPressed: () {
                _scffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(Broken.menu_1)),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://laidlawschool.org/wp-content/themes/navin/assets/images/bg-logo.png",
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
                  ),
                ),
              ),
            )
          ],
        ),
        body: _pages[_selectedIndex]);
  }
}
