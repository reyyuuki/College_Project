import 'package:agarwal_school/core/icons/icons_broken.dart';
import 'package:agarwal_school/provider/theme/theme_provider.dart';
import 'package:agarwal_school/screens/about.dart';
import 'package:agarwal_school/screens/enquiry.dart';
import 'package:agarwal_school/screens/facilities.dart';
import 'package:agarwal_school/screens/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (conetxt) => ThemeProvider(), child: const MainApp()),
  );
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
    const Facilities(),
    const Enquiry(),
    const About()
  ];

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Broken.home;
      case 1:
        return Broken.category;
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
        return "Facilities";
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
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.surface,
          width: 180,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                height: 190,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Center(
                    child: Container(
                      width: 120, 
                      height: 130, 
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, 
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            blurRadius: 40, 
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://laidlawschool.org/wp-content/themes/navin/assets/images/bg-logo.png",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[900]!,
                            highlightColor: Colors.grey[700]!,
                            child: Container(
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: _selectedIndex == index
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: _selectedIndex == index
                          ? [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.5),
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
                              offset: const Offset(0,2)
                            )
                          ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getIconForIndex(index),
                          color: _selectedIndex == index
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.inverseSurface,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _getLabelForIndex(index),
                          style: TextStyle(
                            fontFamily: "LexendDeca",
                            color: _selectedIndex == index
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.inverseSurface,
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
                          blurRadius: 10,
                          color: Theme.of(context)
                              .colorScheme
                              .inverseSurface
                              .withOpacity(0.3),
                          spreadRadius: 1,
                          offset: const Offset(0, 2))
                    ]),
                child: CustomSlidingSegmentedControl(
                    initialValue:
                        Provider.of<ThemeProvider>(context).isDarkMode ? 1 : 2,
                    decoration: const BoxDecoration(color: Colors.transparent),
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
                          ? Provider.of<ThemeProvider>(context, listen: false)
                              .darkTheme()
                          : Provider.of<ThemeProvider>(context, listen: false)
                              .lightTheme();
                    }),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
