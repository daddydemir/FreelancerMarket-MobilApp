

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/Message.dart';
import '../../models/_User.dart';
import '../../service/firebaseService.dart';
import '../../service/user/userService.dart';

class MessagePage extends StatefulWidget{
  const MessagePage({Key? key, required this.data}) : super(key: key);
  final String data;
  @override
  State<StatefulWidget> createState() => _messagePageState(data);

}

class _messagePageState extends State{
  _messagePageState(this.user);
  String user;

  var service = FirebaseService();
  var userService = UserService();
  var from = "";
  var resim ="https://icon-library.com/images/no-user-image-icon/no-user-image-icon-27.jpg";
  var ctrl = TextEditingController();
  var controller = ScrollController();
  
  _veriGetir() async {
    Users u = await userService.getUser();
    from = u.username;
    setState(() {});
  }

  @override
  initState() {
    _veriGetir();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF5CC),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
            child: Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              const SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(resim),
                radius: 20,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${user}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text("Online",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        )),
                  ],
                ),
              ),
              const Icon(Icons.settings, color: Colors.black)
            ],
          ),
        )),
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: service.getMessages(from, user),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              return ListView(
                controller: controller,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 0, bottom: 60),
                    child: Align(
                      alignment: data["from"] != from
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)
                            ),
                          ),
                          color: (data["from"] != from
                              ? const Color.fromRGBO(245, 246, 247,1)
                              : const Color.fromRGBO(13, 110, 253,0.8)),
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left:7, right:3,top:3,bottom:3),
                                child: Text(
                                  data["content"],
                                  style: TextStyle(
                                    color : (data["from"] != from ? Colors.black : Colors.white ), 
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(""),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 7, bottom:2),
                                    child: Text(
                                      DateFormat('HH:mm').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(document.id))),
                                      style: TextStyle(fontSize: 12,
                                      color : (data["from"] != from ? Colors.black : Colors.white ), ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:
                          const Icon(Icons.add, color: Colors.white, size: 20),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                        controller: ctrl,
                        decoration: const InputDecoration(
                          hintText: "Write Message . . .",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        )),
                  ),
                  const SizedBox(width: 15),
                  FloatingActionButton(
                    onPressed: () {
                      _sendMessage();
                    },
                    child:
                        const Icon(Icons.send, color: Colors.white, size: 18),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    await service.sendMessage(Message(id:"" , content:ctrl.text, from:from , to:user));
    ctrl.clear();
    controller.jumpTo(controller.position.maxScrollExtent + 120);
    setState(() {});
  }
}