// ignore_for_file: file_names, unused_import, avoid_print

import 'dart:convert';


import 'dart:io';
import '../../api/freelancer_api.dart';
import '../../models/_User.dart';
import '../user/userService.dart';

class ImageSelector{

  var servis = UserService();
  var api = FreelancerApi();

  Future<void> sendFile(File file) async {
    Users user = await servis.getUser();
    var r = await api.imageUpdate(file, user);
    if(r.statusCode == 200){
      print("Okey : " + json.decode(utf8.decode(r.bodyBytes)).toString());
    }else{
      print("Hata : " + json.decode(utf8.decode(r.bodyBytes)).toString());
    }
  }
}