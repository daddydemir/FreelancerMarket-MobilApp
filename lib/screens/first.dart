
// ignore_for_file: use_key_in_widget_constructors, camel_case_types, prefer_const_constructors, must_call_super

import 'package:flutter/material.dart';

import '../main.dart';
import '../models/_User.dart';
import '../service/user/userService.dart';
import 'login.dart';

class First extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _first();

}

class _first extends State{

  var service = UserService();
  var user = Users.empty();
  

  check() async {
    user = await service.getUser();
    
    if(user.name != "empty"){
      // kullanici var demek bu sebeple ana sayfaya atarim 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HttpApp()));
      return "";
    }
    
    // login sayfasina atmak lazim 
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    
  }

  @override
  void initState() {
    check();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xfff4f5f7),
      body:Column(
        children: const [
          Expanded(
            flex:5,
            child:Image(
              image:AssetImage("lib/assets/icon.png"),
              width:250,
            ),
          ),
          Expanded(
            flex: 2,
            child:Center(
              child:Text("Freelancer Market")
            )
          ),
        ],
      ),
    );
  }
}