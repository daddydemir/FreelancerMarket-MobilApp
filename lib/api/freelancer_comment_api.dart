import 'dart:convert';
import 'dart:io';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:http/http.dart' as http;
class FreelancerCommentApi{

  // eksik
  static Future add(SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/freelancerComments/add");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body:jsonEncode(<String, String>{
        "content":"deneme",
        "freelancerId":"10",
        "userId":user.id.toString(),
      }),
    );
  }

  // eksik
  static Future delete(SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/freelancerComments/delete");
    return await http.delete(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
    );
  }

  static Future getByFreelancerId(SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/freelancerComments/getByFreelancerId?id="+ user.id.toString());
    return await http.get(url);
  }
}