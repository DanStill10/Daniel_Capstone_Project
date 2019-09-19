import 'package:capstone/models/User.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final List<User> userlist = [
    User("Danie", "danielstill46@gmail.com", "Soniccolors1"),
    User("Dave", "dstill30@gmail.com", "jymGreen1"),
    User("Tori", "SonicShadowSilver23@yahoo.com", "Bugabum")
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        itemCount: userlist.length,
        itemBuilder: (BuildContext context, int index) =>
            userCardBuilder(context, index),
      ),
    );
  }

  Widget userCardBuilder(BuildContext context, int index) {
    final user = userlist[index];
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 4.0),
                child: Row(
                  children: <Widget>[
                    Text(user.username,style: TextStyle(fontSize: 25.0),),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(user.email),
                    Spacer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
