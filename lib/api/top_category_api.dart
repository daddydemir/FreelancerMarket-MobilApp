import 'dart:convert';
import 'dart:io';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:http/http.dart' as http;
class TopCategoryApi{

  // bunda da auth yok
  static Future add(SqlUser user, var categoryName) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/topCategories/add");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body:jsonEncode(<String,String>{
        "name":categoryName,
      })
    );
  }

  static Future delete(SqlUser user, var index) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/topCategories/delete?id="+index.toString());
    return await http.delete(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }

  Future getAll() async {
    var url = Uri.parse("http://freelancermarket-backend.herokuapp.com/api/topCategories/getAll");
    return await http.get(url);
  }
}