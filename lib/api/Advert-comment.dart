import 'dart:convert';

import 'package:http/http.dart' as http;

class AdvertCommentApi{


  static Future add() async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/advertComments/add");
    return await http.post(
      url ,
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body:jsonEncode(<String , String>{
    "advertId":"password",
    "content":"username",
    "userId":"",
    }));
  }

  static Future delete(var s) async{
    var  url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/advertComments/delete?advertCommentId"+s);
    return await http.delete(url);
  }

  static Future getById(int id) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/advertComments/getByAdvertId?advertCommentId="+id.toString());
    return await http.get(url);
  }
}