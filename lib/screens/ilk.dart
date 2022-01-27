

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freelancer_market/data/dbHelper.dart';
import 'package:freelancer_market/models/sql_user.dart';

import 'login.dart';

class Ilk extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var s = sqlCheck();
    if(s == true){
      print("burası da çalıştı");
      Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginPage()));
    }else{
      print("tmm ke");
      Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginPage()));
    }
    return Text("Merhaba Dünya");
  }

  sqlCheck() {
    var database = DbHelper();
    var n = database.getUser();
    List<SqlUser> liste = [];
    n.then((data) {
        liste = data;
      print("Uzunluk : " + liste.length.toString());
      if(liste.length>0){
        print("sayfaya geçer");
        return true;
      }else{
        print("geçmer");
        return false;
      }
    });
    
  }

}