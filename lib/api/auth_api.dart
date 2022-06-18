import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/_User.dart';
class AuthApi{

  Future changePassword(Users user, var oldPass, var n1, var n2) async{
    var url = Uri.parse("https://freelancer-market-backend.herokuapp.com/api/auth/changePassword");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "newPassword":n1,
        "newPasswordRepeat":n2,
        "oldPassword":oldPass,
        "userId":user.id.toString(),
      }),
    );
  }

  Future login(var username , var password) async{
    var url = Uri.parse("https://freelancer-market-backend.herokuapp.com/api/auth/login");
    return await http.post(
      url,
      headers:{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String,String>{
        "password":password,
        "userName":username,
      }),
    );
  }

  
}