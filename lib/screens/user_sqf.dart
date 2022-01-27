import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freelancer_market/data/dbHelper.dart';
import 'package:freelancer_market/models/sql_user.dart';

class Userman extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _testState();
  }
}

class _testState extends State {
  DbHelper dbHelper = new DbHelper();
  List<SqlUser> users = [];
  SqlUser amk_ya = SqlUser(1, "boss", "boss");
  int userCount = 0;
  @override
  void initState() {
    var gelenUser = dbHelper.getUser();
    gelenUser.then((data) {
      // bu kısım detaylı incelenecek
      setState(() {
        this.amk_ya = data[0];
        this.users = data;
      });
      users = data;
      print("24 - " + data[0].token);
    });
    print("MC : " + this.users[0].token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get user"),
      ),
      body: buildTest(),
      bottomNavigationBar: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () {
          setState(() {
            amk_ya.username=users[0].token;
            amk_ya.password="best_pass";
          });
        },
        child: Text("Kaf Kef"),
      ),
    );
  }

  buildTest() {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.cyanAccent,
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.yellowAccent, child: Text("M")),
              title: Text(amk_ya.username),
              subtitle: Text(users[position].password),
              onTap: () {
                print(amk_ya.password);
              },
            ),
          );
        });
  }
}
