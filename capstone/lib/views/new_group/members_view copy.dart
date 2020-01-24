import 'package:flutter/material.dart';
//import 'package:capstone/main.dart';
import 'package:capstone/models/Group.dart';

class NewGroupMembersView extends StatelessWidget {
  final Group group;
  NewGroupMembersView({Key key, @required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _membersController = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group - Add Members"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                autofocus: true,
                controller: _membersController,
                decoration: InputDecoration(prefixIcon:Icon(Icons.search))
              ),
            ),
            RaisedButton(
              child: Text("Continue"),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => NewGroupCategoryView()));
              },
            )
          ],
      ),),
    );
  }
}