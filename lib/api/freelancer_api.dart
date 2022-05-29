// ignore_for_file: unused_import, unnecessary_new, unused_local_variable, prefer_collection_literals, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:freelancer_market/models/_User.dart';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../models/freelancer.dart';

class FreelancerApi {
  Future getAll() async {
    var url = Uri.parse(
        "https://freelancermarket-backend.herokuapp.com/api/freelancers/getAll");
    return await http.get(url);
  }

  Future getById(int index) async {
    var url = Uri.parse(
        "https://freelancermarket-backend.herokuapp.com/api/freelancers/getById?id=" +
            index.toString());
    return await http.get(url);
  }

  Future getMostPopularFreelancers() async {
    var url = Uri.parse(
        "https://freelancermarket-backend.herokuapp.com/api/freelancers/getMostPopularFreelancers");
    return await http.get(url);
  }

  
  Future imageUpdate(File file, Users user) async {
    
    var request = http.MultipartRequest('POST',Uri.parse("https://freelancermarket-backend.herokuapp.com/api/freelancers/imageUpdate?id="+user.id.toString()));
    request.files.add(
      http.MultipartFile.fromBytes(
        "file",File(file.path).readAsBytesSync(),filename: file.path,contentType: MediaType("image","jpg")
      )
    );
    request.headers["Authorization"] = "Bearer " + user.token;
    var r = await request.send();
    var response = await http.Response.fromStream(r);
    return response;
  }

  Future update(Users user , Freelancer freelancer) async {
    var url = Uri.parse(
        "https://freelancermarket-backend.herokuapp.com/api/freelancers/update");
    return await http.post(
      url,
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: "Bearer " + user.token,
      },
      body: jsonEncode(<String, dynamic>{
        "about": freelancer.about,
        "appellation": freelancer.appellation,
        "email": freelancer.email,
        "id": user.id,
        "name": freelancer.name,
        "surName": freelancer.surname,
      }),
    );
  }
}
