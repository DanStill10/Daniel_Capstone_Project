import 'package:flutter/material.dart';
import 'package:capstone/main.dart';
import 'package:capstone/models/Group.dart';

class NewGroupCategoryView extends StatelessWidget {
  final Group group;
  NewGroupCategoryView({Key key, @required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _categoryController = new TextEditingController();
    _categoryController.text = group.category;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group - Category"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                autofocus: true,
                controller: _categoryController,
                decoration: InputDecoration(focusColor: primaryColor,prefixIcon: Icon(Icons.people_outline)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(right:4.0),
                    child: Divider(),
                  )),
                  Text("Suggestions"),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left:4.0),
                    child: Divider(),
                  )),
                ],
              ),
            ),
            RaisedButton(
              child: Text("Continue"),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                group.name = _categoryController.text;
                //Navigator.push(context, MaterialPageRoute(builder: (context) => NewGroupCategoryView()));
              },
            )
          ],
      ),),
    );
  }
}