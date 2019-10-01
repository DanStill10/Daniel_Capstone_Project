import 'package:flutter/material.dart';
import 'package:capstone/models/Group.dart';
import 'package:capstone/main.dart';
import 'category_view.dart';

class NewGroupNameView extends StatelessWidget {
  final Group group;
  NewGroupNameView({Key key, @required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = new TextEditingController();
    _nameController.text = group.name;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group - Name"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                autofocus: true,
                controller: _nameController,
                decoration: InputDecoration(focusColor: primaryColor,prefixIcon: Icon(Icons.create)),
              ),
            ),
            RaisedButton(
              child: Text("Continue"),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                group.name = _nameController.text;
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewGroupCategoryView(group: group,)));
              },
            )
          ],
      ),),
    );
  }
}