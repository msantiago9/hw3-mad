import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:hw3marjon/models/message.dart';

class DBServ {
  //This class will contain a reference to the Firestore collection containing user data.

  final String uid;

  DBServ({required this.uid});

  final CollectionReference userDB =
      FirebaseFirestore.instance.collection('userdata');

  Future update(String fname, String lname, String type) async {
    return await userDB
        .doc(uid)
        .set({'fname': fname, 'lname': lname, 'type': type});
  }

  Stream<QuerySnapshot> get userdata {
    return userDB.snapshots();
  }
}

class DBServAdmin {
  final CollectionReference userDB =
      FirebaseFirestore.instance.collection('messages');

  Future update(String message) async {
    String messageID = Uuid().v4();

    return await userDB.doc(messageID).set({'message': message});
  }

  Stream<List<ChatMessage>> get userdata {
    return userDB.snapshots().map(messageListFromSnapshot);
  }

  //message list from snapshot
  List<ChatMessage> messageListFromSnapshot(QuerySnapshot snap) {
    List<ChatMessage> mylist = [];
    if (snap != null) {
      snap.docs.forEach((element) {
        if (element != null) {
          String msg = element.get('message');
          String type = element.get('type');
          mylist.add(ChatMessage(messageContent: msg, messageType: type));
        }
      });
    }
    return mylist;
  }
}
