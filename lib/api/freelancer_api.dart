import 'dart:convert';
import 'dart:io';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:http/http.dart' as http;
class FreelancerApi {

  static Future getAll() async {
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/freelancers/getAll");
    return await http.get(url);
  }

  static Future getById(int index) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/freelancers/getById?id="+ index.toString());
    return await http.get(url);
  }

  static Future getMostPopularFreelancers() async {
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/freelancers/getMostPopularFreelancers");
    return await http.get(url);
  }
  
  // eksik
  static Future imageUpdate(SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/freelancers/imageUpdate?id="+user.id.toString());
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body:"i need this write code",
    );
  }

  // eksik
  static Future update(SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/freelancers/update");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body:jsonEncode(<String, String>{
        "about":"",
        "appellation":"",
        "email":"",
        "id":"",
        "name":"",
        "surName":"",
      }),
    );
  }
  
}