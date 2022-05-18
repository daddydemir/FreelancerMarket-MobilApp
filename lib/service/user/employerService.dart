// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import '../../api/employer.dart';
import '../../models/employer.dart';

class EmployerService{

  var api = EmployerApi();

  Future<Employer> getUser(int employerId) async {
    var r = await api.getById(employerId);
    if(r.statusCode == 200){
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      print("VERI VAR");
      return Employer.fromJson(data);
    }else{
      print("VERI YOK" + r.statusCode.toString());
      return Employer.empty();
    }
  }
}