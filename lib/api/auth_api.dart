import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:freelancer_market/models/sql_user.dart';
class AuthApi{

  static Future changePassword(SqlUser user, var oldPass, var n1, var n2) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/auth/changePassword");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body: jsonEncode(<String, String>{
        "newPassword":n1,
        "newPasswordRepeat":n2,
        "oldPassword":oldPass,
        "userId":user.id.toString(),
      }),
    );
  }

  static Future login(var username , var password) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/auth/login");
    return await http.post(
      url,
      body: jsonEncode(<String,String>{
        "password":password,
        "userName":username,
      }),
    );
  }

  
}