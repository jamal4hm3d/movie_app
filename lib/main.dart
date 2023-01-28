import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_app/screens/home_page.dart';
import 'package:spot_app/screens/discover_page.dart';

void main() async {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPOT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xFFf45cba),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1e203f),
            titleTextStyle: TextStyle(color: Color(0xFFf45cba), fontSize: 25),
          ),
          scaffoldBackgroundColor: const Color(0xFF1e203f),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFf45cba),
          ),
          navigationBarTheme: const NavigationBarThemeData(
            elevation: 0,
            backgroundColor: Color(0xFF1e203f),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            indicatorColor: Color(0xFFf45cba),
          ),
          brightness: Brightness.dark,
          useMaterial3: true),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = const [
      HomePage(title: "home"),
      DiscoverPage(title: "discover"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("MOVIES"),
        leading: const Icon(
          Icons.play_circle_fill,
          color: Color(0xFFf45cba),
          size: 35,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.person), label: "Discover"),
        ],
      ),
      body: screens[currentPageIndex],
    );
  }
}
