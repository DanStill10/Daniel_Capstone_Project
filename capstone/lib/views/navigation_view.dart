import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone/models/Group.dart';
import 'package:capstone/views/new_groups/name_view.dart';
import 'package:flutter/material.dart';

class NavigationView extends StatelessWidget {
  final List<Group> groups = [];
  final newGroup = new Group(null,null,null);
  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty){
      return Container(
        child: new ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) =>
          groupCardBuilder(context, index),
      ),
    );}else{
      return Container(
      child: new ListView.builder(
        itemCount: groups.length,
        itemBuilder: (BuildContext context, int index) =>
          groupCardBuilder(context, index),
      ),
    );
    }
    
  }

  Widget groupCardBuilder(BuildContext context, int index) {
    if (groups.isEmpty){
      return new Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom:4.0 ),
                  child: Row(
                    children: <Widget>[
                      AutoSizeText("You do not have any groups created."),
                      IconButton(
                        icon: Icon(Icons.add),
                        padding: const EdgeInsets.only(left: 20),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewGroupNameView(group: newGroup),),);
                        },
                      )
                    ],
                  ),),
              ],),
            ),
          ),
        ),
      );
    }else{
      final group = groups[index];
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
                    Text(group.name,style: TextStyle(fontSize: 25.0),),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    }
    
  }
}
