import 'dart:convert';
import 'dart:io';
import 'package:freelancer_market/models/advert.dart';
import '../../models/_User.dart';
import 'package:http/http.dart' as http;
class FavoriteApi{

  Future add(int advertId,Users user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/favorities/add");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body: jsonEncode(<String,String>{
        "advertId":advertId.toString(),
        "userId":user.id.toString(),
      }),
    );
  }

  Future delete(int advertId,Users user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/favorities/delete?advertId="+advertId.toString() +"&userId="+user.id.toString());
    return await http.delete(
      url,
      headers: {
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }

  Future getByUserId(Users user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/favorities/getByUserId?userId="+user.id.toString());
    return await http.get(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
    );
  }
}