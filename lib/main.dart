import 'package:flutter/material.dart';
import 'package:trackup/data_manager.dart';
import 'package:trackup/pages/home_page.dart';
import 'package:trackup/pages/menu_page.dart';
import 'package:trackup/pages/profile_page.dart';

/// Flutter code sample for [NavigationDrawer].

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination(
      'Home', Icon(Icons.home_outlined), Icon(Icons.home_rounded)),
  ExampleDestination(
      'Discover', Icon(Icons.search_rounded), Icon(Icons.search)),
  ExampleDestination('Train', Icon(Icons.fitness_center_rounded),
      Icon(Icons.fitness_center_rounded)),
  ExampleDestination('Goals', Icon(Icons.trending_up_rounded),
      Icon(Icons.trending_up_rounded)),
  ExampleDestination('Profile', Icon(Icons.face_outlined), Icon(Icons.face)),
];

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.orange,
          ).copyWith(secondary: Colors.orangeAccent)),
      home: const RootApp(),
    ),
  );
}

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  DataManager dataManager = DataManager();
  showSelectedScreen(int index) {
    switch (index) {
      case 0:
        return HomePage(
          dataManager: dataManager,
        );
      case 1:
        return MenuPage(
          dataManager: dataManager,
        );
      case 2:
        return const ProfilePage();
      case 3:
        return const ProfilePage();
      case 4:
        return const ProfilePage();
      default:
        return const Text('Error');
    }
  }

  int screenIndex = 0;
  late bool showNavigationDrawer;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  Widget buildBottomBarScaffold() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            showSelectedScreen(screenIndex),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            screenIndex = index;
          });
        },
        destinations: destinations.map(
          (ExampleDestination destination) {
            return NavigationDestination(
              label: destination.label,
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
              tooltip: destination.label,
            );
          },
        ).toList(),
      ),
    );
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Row(
          children: <Widget>[
            Container(
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: NavigationRail(
                  minWidth: 50,
                  labelType: NavigationRailLabelType.selected,
                  destinations: destinations.map(
                    (ExampleDestination destination) {
                      return NavigationRailDestination(
                        label: Text(destination.label),
                        icon: destination.icon,
                        selectedIcon: destination.selectedIcon,
                      );
                    },
                  ).toList(),
                  selectedIndex: screenIndex,
                  useIndicator: true,
                  onDestinationSelected: (int index) {
                    setState(() {
                      screenIndex = index;
                    });
                  },
                ),
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),

            // True body
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  showSelectedScreen(screenIndex),
                  ElevatedButton(
                    onPressed: openDrawer,
                    child: const Text('Open Drawer'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Header',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ...destinations.map(
            (ExampleDestination destination) {
              return NavigationDrawerDestination(
                label: Text(destination.label),
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 650;
  }

  @override
  Widget build(BuildContext context) {
    return showNavigationDrawer
        ? buildDrawerScaffold(context)
        : buildBottomBarScaffold();
  }
}
