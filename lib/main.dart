import 'package:flutter/material.dart';
import 'package:flutter_application_1/data_manager.dart';
import 'package:flutter_application_1/pages/menu_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'TrackUp',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

// Homepage widget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  var dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    currentPage(int index) {
      switch (index) {
        case 0:
          return HomePage(dataManager: dataManager);
        case 1:
          return MenuPage(dataManager: dataManager);
        case 2:
          return const ProfilePage();
        default:
          return const Text('Error');
      }
    }

    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/logo.png')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex) => setState(() {
          selectedIndex = newIndex;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: currentPage(selectedIndex),
    );
  }
}
