// ignore_for_file: unused_import, unnecessary_new, unused_local_variable, prefer_collection_literals

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:freelancer_market/models/_User.dart';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

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

  // eksik
  Future imageUpdate(File file, Users user) async {
    
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/freelancers/imageUpdate?id=" +user.id.toString());
    var request = http.MultipartRequest("POST",url);

    
    request.headers["Authorization"] = "Bearer " + user.token;
    
    //var picture = http.MultipartFile.fromBytes("file", "");

    //request.files.add(picture);

    return await http.post(
      url,
      headers: {
        "Content-Type": "multipart/form-data",
        HttpHeaders.authorizationHeader: "Bearer " + user.token,
      },
      body:{
        "file": "imageBytes"
      }
    );
  }

  // eksik
  static Future update(SqlUser user) async {
    var url = Uri.parse(
        "https://freelancermarket-backend.herokuapp.com/api/freelancers/update");
    return await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + user.token,
      },
      body: jsonEncode(<String, String>{
        "about": "",
        "appellation": "",
        "email": "",
        "id": "",
        "name": "",
        "surName": "",
      }),
    );
  }
}
