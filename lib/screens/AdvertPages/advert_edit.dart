// ignore_for_file: non_constant_identifier_names, camel_case_types, must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';

class AdvertEdit extends StatefulWidget{
  AdvertEdit({Key? key , required this.UserId}) : super(key: key);
  int UserId;

  @override
  State<StatefulWidget> createState() => _advertEdit(UserId);

}

class _advertEdit extends State{
  _advertEdit(this.userId);
  int userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child:Text("Merhaba Dünya $userId"))
    );
  }
}