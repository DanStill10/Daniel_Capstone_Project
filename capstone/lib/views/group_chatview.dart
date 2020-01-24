import 'package:capstone/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone/services/data_service.dart';
import 'package:capstone/services/auth_service.dart';
import 'package:capstone/widgets/custom_submit.dart';
import 'package:capstone/views/signup_view.dart';
import 'package:capstone/widgets/message_widget.dart';
import 'package:capstone/widgets/provider_widget.dart';


class GroupChat extends StatefulWidget {
  final String groupId;

  const GroupChat({Key key, @required this.groupId}) : super(key: key);
  @override
  _GroupChatState createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  final Firestore _firestore = Firestore.instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController messageController = TextEditingController();

  ScrollController scrollController = ScrollController(initialScrollOffset:0.0,keepScrollOffset:true);

  Future<void> callback() async{
    if (messageController.text.length > 0){
      FirebaseUser user = await _firebaseAuth.currentUser();
      var id ;
      await _firestore.collection('groupMessages').where('groupId',isEqualTo: this.widget.groupId).getDocuments().then((query) => {
        id = query.documents[0].documentID,
        _firestore.runTransaction((transaction) async{
          await transaction.update(_firestore.collection('groupMessages').document(id), {
            'messages' : {
              'from' : user.email,
              'message' : messageController.text
            }
          });
        }),
        });
        messageController.clear();
    }
  }
  
  Future<String> getUserEmail() async {
    final FirebaseUser usr = await _firebaseAuth.currentUser();
    return usr.email;
  }

 Widget getxMessages(){
    return FutureBuilder<String>(
      future: getUserEmail(),
      builder: (context, snapshot) {
         if(snapshot.hasData){
            var email = snapshot.data;
            return StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('groupMessages').where('groupId',isEqualTo:this.widget.groupId ).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: SpinKitChasingDots(
                        color: primaryColor,
                      ),
                    );}
                  if (snapshot.hasData){
                    DocumentSnapshot doc = snapshot.data.documents.first;

                    var messages = doc['messages'].map((doc) => Message(
                      from: doc['from'],
                      text: doc['text'],
                      me: email == doc['from'],
                    ));

                    if(messages.length == 0){
                      return ListView(
                        padding:const EdgeInsets.only(top: 1),
                        children: <Widget>[
                        Padding(
                        padding: const EdgeInsets.only(top: 150.0),
                        child: Text(
                        'This group has no messages logged',
                        style: TextStyle(color: Colors.white,fontSize: 20.0), 
                        textAlign: TextAlign.center,
                        ),)
                        ],
                      );
                    }
                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages
                    ],
                  );}
                }
              );
         }//else
         else{
          return Text('No user found', style: TextStyle(color: Colors.white),);
         } 
      }
    );
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Hero(
          tag: 'logo',
          child: Container(
            height: 40,
            child: Image.asset('assets/network.png'),
          ),
        ),
        title: Text(
          "Get Together",
          style: TextStyle(fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed Out");
              } catch (e) {
                print(e);
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: getxMessages()
             
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => callback,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 15.0),
                        border: const OutlineInputBorder(),
                        hintText: "Enter a Message...",
                      ),
                      controller: messageController,
                    ),
                  ),
                  SendButton(
                    text: "Send",
                    callback: callback,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
