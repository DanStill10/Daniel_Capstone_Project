import 'package:capstone/views/group_chatview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone/services/data_service.dart';
import 'package:capstone/views/new_group/name_view.dart';
import 'package:capstone/models/Group.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NavigationView extends StatefulWidget {
  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  DataService _dataService = new DataService();
  Stream<QuerySnapshot> groups;

  final newGroup = new Group(null, null, null);

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: groupDisplayBuilder(),
    );
  }
  Widget groupDisplayBuilder() {
    return FutureBuilder(
      future: _dataService.getCurrentUserGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
            return SpinKitChasingDots(
            color: Colors.blue, size: 40.0, duration: Duration(seconds: 2));}
        if (snapshot.hasData) {
          return StreamBuilder(
            stream: snapshot.data,
            builder: (context, snap) {
            if(snap.data == null){
              if(snap.data.documents.length == 0){
              return Container(
              child: Padding(
              padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, bottom: 435.0, top: 20.0),
              child: InkWell(
              child: Card(
              color: Colors.blueAccent,
              child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
              children: <Widget>[
              Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: Row(
              children: <Widget>[
              AutoSizeText(
              "You do not have any groups created.",style: TextStyle(color: Colors.white)),
              Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(
              Icons.add,
                ),
              ),
              ],
              ),
              ),
              ],
              ),
              ),
              ),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => NewGroupNameView(group: newGroup),
              ),
              );
              },
              ),
            ),
            );
          }
          return Text('Error rendering widgets',style: TextStyle(color: Colors.white),);
          }
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: snap.data.documents.length,
            itemBuilder: (context, i){
              DocumentSnapshot  doc = snap.data.documents[i];
              return Container(
                child:InkWell(
                  child:Card(
                  color: Colors.blueAccent,
                  child:Column(
                  children: <Widget>[
                    Text(doc['name'], style: TextStyle(fontSize: 18,color: Colors.white),),
                    SizedBox(height: 10,),
                    Text(doc['owner'], style: TextStyle(fontSize: 12,color: Colors.white),)
                  ],
                  ),
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GroupChat(groupId: doc.documentID,)));
                  },
                  )
              );
            }
            );
          }
        );
        }
        return Text('Problems ocurred while fetching data!',textAlign: TextAlign.center,style: TextStyle(fontSize:20.0),);
      }
      );
      }
}