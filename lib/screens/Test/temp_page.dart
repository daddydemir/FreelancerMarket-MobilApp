import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/temp/navbar.dart';

// ignore: use_key_in_widget_constructors
class TempPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _tempPageState();
  }

}

// ignore: camel_case_types
class _tempPageState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:const Text("Deneme"),
      ),
      bottomNavigationBar:const NavBar(),
    );
  }
}