import 'package:capstone/views/group_chatview.dart';
import 'package:capstone/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone/models/Group.dart';
import 'package:capstone/main.dart';

class NewGroupNameView extends StatelessWidget {
  final Group group;
  final DataService _dataService = new DataService();
  NewGroupNameView({Key key, @required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = new TextEditingController();
    group.name = _nameController.text;
    DocumentReference documentReference;
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
              child: Text("Create Group"),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () async{
                group.name = _nameController.text;
                _dataService.createGroup(group).then((doc){
                  print('Document Created with ID:'+ doc.documentId);
                  documentReference= doc;
                });
                MaterialPageRoute(builder: (context) => GroupChat(groupId:documentReference.documentID));
              },
            )
          ],
      ),),
    );
  }
}