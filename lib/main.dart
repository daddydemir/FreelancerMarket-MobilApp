import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/Test/temp_page.dart';

void main() => runApp(HttpApp());

class HttpApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:TempPage(),
      //TempPage(),
    );
  }

}
