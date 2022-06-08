// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:http/http.dart' as http;

import '../models/_User.dart';
import '../models/comments.dart';

class AdvertCommentApi {


  static Future add(SqlUser user) async {
    var url = Uri.parse(
        "https://freelancermarket-backend.herokuapp.com/api/advertComments/add");
    return await http.post(url,
        headers: <String, String>{
          HttpHeaders.authorizationHeader: user.token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "advertId": "password",
          "content": "username",
          "userId": user.id.toString(),
        },));
  }

  static Future delete(var s) async {
    var url = Uri.parse(
        "https://freelancermarket-backend.herokuapp.com/api/advertComments/delete?advertCommentId" +
            s);
    return await http.delete(url);
  }

  Future getByAdvertId(Advert advert) async {
    var url = Uri.parse(
        "https://freelancer-market-backend.herokuapp.com/api/advertComments/getByAdvertId?advertId=" +
            advert.id.toString());
    return await http.get(url);
  }

  Future commentResponseAdd(Comments comment , Users user , String yorum) async {
    var url = Uri.parse("https://freelancer-market-backend.herokuapp.com/api/advertCommentResponses/add");
    return await http.post(
      url,
      headers:{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body: jsonEncode(<dynamic , dynamic>{
        "advertCommentId": comment.id,
        "userId": user.id,
        "content": yorum
      }),
    );
  }
}
