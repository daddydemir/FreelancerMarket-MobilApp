// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:freelancer_market/service/user/userService.dart';

import '../../api/employer.dart';
import '../../models/employer.dart';

class EmployerService{

  var service = UserService();
  var api = EmployerApi();

  Future<Employer> getUser(int employerId) async {
    var r = await api.getById(employerId);
    if(r.statusCode == 200){
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      return Employer.fromJson(data);
    }else{
      return Employer.empty();
    }
  }

  Future<bool> update(Employer employer) async {
    var r = await api.update(await service.getUser(), employer);
    if(r.statusCode == 200){
      return true;
    }else{
      print(json.decode(utf8.decode(r.bodyBytes)));
      return false;
    }
  }

  Future imageUpdate(File file) async {
    var r = await api.imageUpdate(file , await service.getUser());
    if(r.statusCode == 200){
      print("resim güncellendi");
    }
    else{
      print(json.decode(utf8.decode(r.bodyBytes)));
      print("hata");
    }
  }
}