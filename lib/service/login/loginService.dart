// ignore_for_file: file_names

import 'dart:convert';

import 'package:freelancer_market/data/databaseHelper.dart';

import '../../api/auth_api.dart';
import '../../models/_User.dart';

class LoginService{

  Future login(var username , var password) async{
    AuthApi.login(username , password).then((response) async {
      if(response.statusCode == 200){
        var r = json.decode(utf8.decode(response.bodyBytes));
        var user = Users.fromJson(r['data']);
        var db = DatabaseHelper();
        await db.insert(user);
      }
      else if(response.statusCode == 400){
        // wrong password
      }else{
        // error
      }
    });
  }
}