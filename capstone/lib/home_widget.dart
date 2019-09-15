import 'package:flutter/material.dart';

import 'package:capstone/pages/home_page.dart';
import 'package:capstone/pages/groups_page.dart';
import 'package:capstone/pages/user_search.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    UserSearchPage(),
    GroupsPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
     _currentIndex = index; 
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Get 2 Gether",
          style: TextStyle(fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),

      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: new Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text("Groups"),
            icon: new Icon(Icons.people),
          ),
          BottomNavigationBarItem(
            title: Text("Search Users"),
            icon: new Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
