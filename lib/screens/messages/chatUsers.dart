

import 'package:flutter/material.dart';

import '../../service/firebaseService.dart';
import '../../service/user/userService.dart';
import 'messagePage.dart';

class ChatPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _chatPage();

}

class _chatPage extends State {

  var service = FirebaseService();
  var userService = UserService();
  var liste = [];

  _veriGetir() async {
    liste =  await service.getContactUsers(await userService.getUser());
    setState(() {});
  }

  @override
  initState() {
    _veriGetir();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Sohbetler",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Yeni Sohbet",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: liste.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MessagePage(data: liste[index])));
                  },
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage("lib/assets/nouser.png"),
                    ),
                    title:Text(liste[index]),
                    subtitle: const Text("Selam aga nasılsın"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}