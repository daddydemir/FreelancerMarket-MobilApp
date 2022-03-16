import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/Test/temp_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HttpApp());
}

// ignore: use_key_in_widget_constructors
class HttpApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        scaffoldBackgroundColor: const Color(0xfff4f5f7),
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
