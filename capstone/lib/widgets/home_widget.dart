import 'package:capstone/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'provider_widget.dart';
import 'package:capstone/views/home_view.dart';
import 'package:capstone/views/explore_view.dart';
import 'package:capstone/views/search_view.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}
class _HomeState extends State<Home> {
  int _currentIndex = 0;
  
  final List<Widget> _children = [
    HomeView(),
    SearchView(),
    ExploreView(),
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
          "Get Together",
          style: TextStyle(fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () async{
              try{
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed Out");
              }catch(e){
                print(e);
              }
            },
          )
        ],
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
            title: Text("Search Users"),
            icon: new Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            title: Text("Discover"),
            icon: new Icon(Icons.explore),
          ),
        ],
      ),
    );
  }
}
