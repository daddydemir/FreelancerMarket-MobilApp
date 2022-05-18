// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Message.dart';
import '../models/_User.dart';

class FirebaseService{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(Message message) async { 
    print("kimden" + message.from);
    var id = DateTime.now().microsecondsSinceEpoch.toString();

    var newTime = "";
    var liste = id.split("");
    for(int i = 0;i<13;i++){
      newTime = newTime + liste[i];
    }

    await _firestore.collection(message.from).doc(message.to).set({});
    await _firestore.collection(message.to).doc(message.from).set({});

    var from = _firestore.collection(message.from).doc(message.to).collection("Mesajlar");
    var to = _firestore.collection(message.to).doc(message.from).collection("Mesajlar");

    await from.doc(newTime).set({"content" : message.content , "from":message.from , "to":message.to});
    await to.doc(newTime).set({"content": message.content , "from": message.from , "to": message.to});
  }

  Stream<QuerySnapshot> getMessages(var from , var to) {
    var ref = _firestore.collection(from).doc(to).collection("Mesajlar").snapshots();
    return ref;
  }

  Future<List> getContactUsers(Users user) async { 
    var list = [];
    var querySnapshot = await _firestore.collection(user.username).get();
    for(int i=0;i<querySnapshot.docs.length; i++){
      list.add(querySnapshot.docs[i].id);
    }
    print("this :" + list.toString());
    return list;
  }
}