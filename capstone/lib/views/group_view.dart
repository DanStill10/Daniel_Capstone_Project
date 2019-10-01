import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone/widgets/custom_submit.dart';
import 'package:capstone/widgets/message_widget.dart';
import 'package:capstone/views/signup_view.dart';
import 'package:capstone/services/auth_service.dart';
import 'package:capstone/widgets/provider_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GroupChat extends StatefulWidget {
  final FirebaseUser user;

  const GroupChat({Key key, this.user}) : super(key: key);
  @override
  _GroupChatState createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async{
    if (messageController.text.length > 0){
      await
      _firestore.collection('messages').add({
        'text' : messageController.text,
        'from' : widget.user.email,
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent, 
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 300),
      );
    }
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
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: SpinKitChasingDots(
                        color: primaryColor,
                      ),
                    );

                    List<DocumentSnapshot> docs = snapshot.data.documents;
                  
                    Iterable<Message> messages = docs.map((doc) => Message(
                      from: doc.data['from'],
                      text: doc.data['text'],
                      me: widget.user.email == doc.data['from'],
                    ));
                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages,
                    ],
                  );
                },
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => callback,
                      decoration: InputDecoration(
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
