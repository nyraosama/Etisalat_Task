import 'package:flutter/material.dart';
import 'Favourites Screen.dart';
import 'Home body.dart';

class HomeScreen extends StatefulWidget {
  static const String id='Home Screen';


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex=0;
  final Screens=[
    HomeBody(),
    FavouritesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Screens.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.greenAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        iconSize: 40.0,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.greenAccent,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
            backgroundColor: Colors.greenAccent,
          )
        ],


      ),
    );
  }
}
