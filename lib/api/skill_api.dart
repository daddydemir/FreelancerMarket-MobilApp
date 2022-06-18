import 'dart:convert';
import 'dart:io';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:http/http.dart' as http;
class SkillApi{

  static Future add(SqlUser user, var skillname) async{
    var url = Uri.parse("https://freelancer-market-backend.herokuapp.com/api/skills/add");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body:jsonEncode(<String,String>{
        "freelancerId":user.id.toString(),
        "name":skillname,
      })
    );
  }

  // eksik galiba skill id yi istiyor
  static Future delete(SqlUser user) async{
    var url = Uri.parse("https://freelancer-market-backend.herokuapp.com/api/skills/delete?id=");
    return await http.delete(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
    );
  }

  static Future getByFreelancerId(var index) async{
    var url = Uri.parse("https://freelancer-market-backend.herokuapp.com/api/skills/getByFreelancerId?id="+ index.toString());
    return await http.get(
      url,
    );
  }
}