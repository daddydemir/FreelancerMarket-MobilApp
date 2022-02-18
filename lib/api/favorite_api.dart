import 'dart:convert';
import 'dart:io';
import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:http/http.dart' as http;
class FavoriteApi{

  static Future add(Advert advert,SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/favorities/add");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body: jsonEncode(<String,String>{
        "advertId":advert.id.toString(),
        "userId":user.id.toString(),
      }),
    );
  }

  static Future delete(Advert advert,SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/favorities/delete?advertId="+advert.id.toString() +"&userId="+user.id.toString());
    return await http.delete(
      url,
      headers: {
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }

  static Future getByUserId(SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/favorities/getByUserId?userId="+user.id.toString());
    return await http.get(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
    );
  }
}