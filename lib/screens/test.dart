
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/auth_api.dart';
import 'package:freelancer_market/api/sub_category_api.dart';
import 'package:freelancer_market/api/top_category_api.dart';
import 'package:freelancer_market/data/dbHelper.dart';
import 'package:freelancer_market/models/login.dart';
import 'package:freelancer_market/models/top_category.dart';

class TestScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TestScreenState();
  }

}

class TestScreenState extends State{
  @override
  Widget build(BuildContext context) {
    return Text("Selam dünya");
  }

  @override
  void initState(){
    print("kullanici getirir mi ?");
    dbTest();
    super.initState();
  }

  void getAllFromApi(){
    TopCategoryApi.getAll().then((response){
      setState((){
        String gelen = utf8.decode(response.bodyBytes);
        print(gelen);
      });
    });
  }

  void getSubCategoryAll(){
    var TC1 = TopCategory(5,"Fake");
    SubCategoryApi.getByTopCategoryId(3).then((response){
      setState((){
        String gelen = utf8.decode(response.bodyBytes);
        print(gelen);
      });
    });
  }

  void getJwtToken(){
    var login1 = Login("demir","mehmet12345");
    AuthApi.login("demir","mehmet12345").then((response){
      setState((){
        var gelen = json.decode(utf8.decode(response.bodyBytes));
        gelen = gelen["jwtToken"];
        print("Yazıyor yazıyor yazıyor . . .");
        print(gelen);
      });
    });
  }

  void dbTest(){
    var database = DbHelper();
    database.getUser();
  }
}