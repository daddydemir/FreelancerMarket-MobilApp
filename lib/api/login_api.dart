import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginApi{

  static Future getJwtToken(String username , String password) async {
    var url = Uri.parse("http://freelancermarket-backend.herokuapp.com/api/auth/login");
    return await http.post(
      url ,
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body:jsonEncode(<String , String>{
    "password":password,
    "userName":username,
    }));
  }
}