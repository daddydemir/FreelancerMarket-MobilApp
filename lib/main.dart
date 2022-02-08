import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/Test/temp_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(HttpApp());

// ignore: use_key_in_widget_constructors
class HttpApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        textTheme:GoogleFonts.ubuntuTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:TempPage(),
      //TempPage(),
    );
  }

}
