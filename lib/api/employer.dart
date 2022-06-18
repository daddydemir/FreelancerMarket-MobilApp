import 'dart:convert';
import 'dart:io';

import 'package:freelancer_market/models/_User.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/employer.dart';
class EmployerApi{

  static Future getAll() async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/employers/getAll");
    return await http.get(url);
  }

  Future getById(int id) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/employers/getById?id="+id.toString());
    return await http.get(url);
  }

  Future update(Users user, Employer employer) async {
    var url = Uri.parse("https://freelancer-market-backend.herokuapp.com/api/employers/update");
    return await http.post(
      url,
      headers:{
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body: jsonEncode(<String,dynamic>{
        "about":employer.about,
        "email":employer.email,
        "id":user.id,
        "name":employer.name,
        "surName": employer.surname,
      })
    );
  }

  Future imageUpdate(File file, Users user) async {
    var request = http.MultipartRequest("POST" , Uri.parse("https://freelancer-market-backend.herokuapp.com/api/employers/imageUpdate?id=" + user.id.toString()));
    request.files.add(
      http.MultipartFile.fromBytes(
        "file", 
        File(file.path).readAsBytesSync(),
        filename:file.path,
        contentType: MediaType("image","jpg")
        )
    );
    request.headers["Authorization"] = "Bearer " + user.token;
    var r = await request.send();
    var response = await http.Response.fromStream(r);
    return response;
  }

}