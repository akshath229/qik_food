import 'package:flutter/material.dart';
import '../cart/cart_history.dart';
import '../cart/cart_page.dart';
import 'homepagetwo.dart';

class Mainhomepage extends StatefulWidget {
  const Mainhomepage({Key? key}) : super(key: key);

  @override
  State<Mainhomepage> createState() => _MainhomepageState();
}

int _selectedIndex = 0;
List pages = [
  Firsthomepage(),
  CartHistory(),

  Firsthomepage(),
  Firsthomepage(),
];

class _MainhomepageState extends State<Mainhomepage> {
  void ontapnavbar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.onlyShowSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: _selectedIndex,
        onDestinationSelected: ontapnavbar,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.commute_outlined),
            label: 'Commute',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
