// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:io';

import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:freelancer_market/models/user.dart';
import 'package:http/http.dart' as http;
class AdvertApi{

  // resim olduğu için sona bırakıyorum
  static Future Add() async{
    var url = Uri.parse("");
  }

  // [x]
  static Future Delete(Advert advert, SqlUser user) async {
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/adverts/delete?advertId="+advert.id.toString());
    return await http.delete(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
    );
  }

  static Future getByFreelancerId(User user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/adverts/getByFreelancerId?freelancerId="+user.id.toString());
    return await http.get(url);
  }

  static  Future getById(Advert advert) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/adverts/getById?id="+advert.id.toString());
    return await http.get(url);
  }
  // [resim olduğu için patlar ]
  static Future Update(Advert advert, SqlUser user)async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/adverts/update");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader: "Bearer "+ user.token,
      },
      body:jsonEncode(<String, String>{
        "freelancerId":user.id.toString(),
        "id": advert.id.toString(),
        "imagePath": advert.image_path,
        "info": advert.info,
        "price": advert.price.toString(),
        "subCategoryId": advert.sub_category_id.toString(),
        "title":advert.title,
      }),
    );
  }

  static Future getAllAdverts() async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/adverts/getAll");
    return await http.get(url);
  }

  Future getBySubCategoryId(int index) async {
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/adverts/getBySubCategoryId?subCategoryId="+ index.toString());
    return await http.get(url);
  }

  Future getMostPopularAdverts() async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/adverts/getMostPopularJobAdverts");
    return await http.get(url);
  }
}