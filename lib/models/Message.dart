

import 'package:cloud_firestore/cloud_firestore.dart';

class Message{

  String id;
  String content;
  String from;
  String to;

  Message({ required this.id,required this.content,required this.from,required this.to});

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    return Message(
      id: snapshot.id,
      content: snapshot["content"],
      from:snapshot["from"],
      to:snapshot["to"]
    );
  }
}