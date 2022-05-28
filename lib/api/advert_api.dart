// ignore_for_file: non_constant_identifier_names, unused_local_variable
import 'dart:convert';
import 'dart:io';

import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/_User.dart';


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

  Future getByFreelancerId(int user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/adverts/getByFreelancerId?freelancerId="+user.toString());
    return await http.get(url);
  }

  static  Future getById(Advert advert) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/adverts/getById?id="+advert.id.toString());
    return await http.get(url);
  }
  
  Future Update(Advert advert, File file, Users user)async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/adverts/update");
    var request = http.MultipartRequest("POST",url);
    request.files.add(
      http.MultipartFile.fromBytes("file",File(file.path).readAsBytesSync(),filename:file.path,contentType:MediaType("image","jpg"))
    );
    request.headers["Authorization"] = "Bearer " + user.token;
    request.fields["freelancerId"] = user.id.toString();
    request.fields["id"] = advert.id.toString();
    request.fields["info"] = advert.info;
    request.fields["price"] = advert.price.toString();
    request.fields["subCategoryId"] = advert.sub_category_id.toString();
    request.fields["title"] = advert.title;

    var r = await request.send();
    var response = await http.Response.fromStream(r);
    return response;
    
    /* return await http.post(
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
    ); */
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

  Future getByFilter(String term) async{
    var url = Uri.parse("https://freelancer-market-backend.herokuapp.com/api/adverts/getBySearchFilter");
    return await http.post(
      url,
      headers:{
        "Content-Type": "application/json",
      },
      body:jsonEncode(<String, String>{
        "term":term
      })
    );
  }
}