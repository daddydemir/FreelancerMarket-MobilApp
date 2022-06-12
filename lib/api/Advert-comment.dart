// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:freelancer_market/models/advert.dart';
import 'package:http/http.dart' as http;

import '../models/_User.dart';
import '../models/comments.dart';

class AdvertCommentApi {


  Future add(Users user , Advert advert , String comment) async {
    
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/advertComments/add");
    return await http.post(url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + user.token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "advertId": advert.id,
          "content": comment,
          "userId": user.id,
          "score":3
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
