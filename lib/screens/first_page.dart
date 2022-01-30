import 'package:flutter/material.dart';
import 'package:freelancer_market/data/dbHelper.dart';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:freelancer_market/screens/login.dart';

class FisrtPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _firstState();
  }
}

class _firstState extends State {
  List<SqlUser> liste = [];
  @override
  Widget build(BuildContext context) {
    sqlCheck();
    return TextButton(
      style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff3a65aa)),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginPage()));
                },
                child: const Text('Giriş Yap',
                style: TextStyle(
                  fontSize:20,
                )),
              );
  }

  void sqlCheck() {
    var database = DbHelper();
    var n = database.getUser();

    n.then((data) {
      setState(() {
        liste = data;
      });
      print("Uzunluk : " + liste.length.toString());
    });
    
  }
}
