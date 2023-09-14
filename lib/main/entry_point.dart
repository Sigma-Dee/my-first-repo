import 'package:flutter/material.dart';
import 'package:untitled_project/main/screens/favorites.dart';
import 'package:untitled_project/main/screens/home.dart';
import 'package:untitled_project/main/screens/search.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  // map Current Page
  int currentIndex = 0;
  // Page List
  final screens = [
    //Search Page Screen
    const SearchScreen(),
    //Home Page Screen
    const HomeScreen(),
    //Favorites Page Screen
    const FavoritesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue.shade100,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: currentIndex,
          onDestinationSelected: (index) =>
              setState(() => currentIndex = index),
          //backgroundColor: Colors.blue.shade50.withOpacity(0.1),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              label: 'Search',
              selectedIcon: Icon(Icons.manage_search_outlined),
            ),
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              label: 'Liked',
              selectedIcon: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
    );
  }
}
