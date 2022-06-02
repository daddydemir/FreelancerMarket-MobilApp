import 'dart:convert';
import 'dart:io';
import 'package:freelancer_market/models/advert.dart';
import 'package:http/http.dart' as http;

import '../models/_User.dart';
class OrderApi{

  // yeni backend çalışmıyor.
  Future add(Advert advert,Users user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/add");
    return await http.post(
      url,
      headers:{
        "Content-Type": "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body:jsonEncode(<String,dynamic>{
        "advertId":advert.id,
        "userId":user.id,
      }),
    );
  }

  // eksik -> neyin id'sini istiyor emin değilim. : orderId sanırım.
  static Future confirm(Users user) async{
    var url = Uri.parse("https://freelancer-market-backend.herokuapp.com/api/orders/confirm?id=");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
    );
  }

  Future getAll(Users user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/getAll");
    return await http.get(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }
  
  static Future getByFreelancerId(Users user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/getByFreelancerId?id="+user.id.toString());
    return await http.get(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }

  // 
  static Future getByUserId(Users user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/getByUserId?id="+user.id.toString());
    return await http.get(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }
}