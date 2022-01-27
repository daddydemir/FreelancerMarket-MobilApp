import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/Test/temp_page.dart';
import 'package:freelancer_market/screens/first_page.dart';
import 'package:freelancer_market/screens/home/home_page.dart';
import 'package:freelancer_market/screens/home/silinecek.dart';
import 'package:freelancer_market/screens/ilk.dart';
import 'package:freelancer_market/screens/login.dart';
import 'package:freelancer_market/screens/main_page.dart';
import 'package:freelancer_market/screens/test.dart';
import 'package:freelancer_market/screens/user/user_page.dart';
import 'package:freelancer_market/screens/user_detail.dart';
import 'package:freelancer_market/screens/user_edit.dart';
import 'package:freelancer_market/screens/user_sqf.dart';
import 'package:freelancer_market/screens/wallet_page.dart';

import 'data/dbHelper.dart';
import 'models/sql_user.dart';


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
