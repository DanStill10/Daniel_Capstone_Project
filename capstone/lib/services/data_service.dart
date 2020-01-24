import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataService {
  Firestore _firestore = Firestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 
  Future<Stream<QuerySnapshot>> getCurrentUserGroups() async {
    var user = await _firebaseAuth.currentUser();
    Stream<QuerySnapshot>query = _firestore.collection('groups').where('members',arrayContains: user.email).snapshots();
    return query;
  }

  getCurrentUser() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  createGroup(group) async {
    var usr = await _firebaseAuth.currentUser();
    await _firestore.collection('groups').add(
      {
        'name': group.name,
        'owner': usr.email,
        'members': [usr.email],
      },
    ).then((doc) {
      _firestore.collection('groupMessages').add({
        'GroupId': doc.documentID,
        'messages': [],
      });
    });
  }

  addGroupMember(user, group) async {
    _firestore.runTransaction((Transaction transaction) async {});
  }
}
