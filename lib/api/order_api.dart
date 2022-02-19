import 'dart:convert';
import 'dart:io';
import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:http/http.dart' as http;
class OrderApi{

  static Future add(Advert advert,SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/add");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body:jsonEncode(<String,String>{
        "advertId":advert.id.toString(),
        "userId":user.id.toString(),
      }),
    );
  }

  // eksik -> neyin id'sini istiyor emin değilim.
  static Future confirm(SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/confirm?id=");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
    );
  }

  static Future getAll(SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/getAll");
    return await http.get(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }
  
  static Future getByFreelancerId(SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/getByFreelancerId?id="+user.id.toString());
    return await http.get(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }

  // 
  static Future getByUserId(SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/getByUserId?id="+user.id.toString());
    return await http.get(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }
}