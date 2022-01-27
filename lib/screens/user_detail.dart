import 'package:flutter/material.dart';

class UserDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _userDetailWidget();
  }
}

class _userDetailWidget extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f5f7),
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://raw.githubusercontent.com/daddydemir/images/main/temp/darkknight.jpg"),
                ),
              ),
            ),
            Row(children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("Mehmet \nÇakmaktaşı",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xff81352e))),
              )),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Hacker",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Color(0xff0c0d0f))))),
            ]),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context,index){
                return ListTile(
                  title:Text("DemirX"+index.toString()),
                );
              },
            ),
            

          ],
        ),
      ),
    );
  }
}
