import 'package:flutter/material.dart';

//import 'package:capstone/views/firstview.dart';
import 'package:capstone/home_widget.dart';

void main() => runApp(MyApp());

final primaryColor = const Color(0xFF5B89FF);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Get 2 Gether App",
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      routes: <String, WidgetBuilder>{
        "/signUp": (BuildContext context) => Home(),
        "/home": (BuildContext context) => Home(),
      },
    );
  }
}
