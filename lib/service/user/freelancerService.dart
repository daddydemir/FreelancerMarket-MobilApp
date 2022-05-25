// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'dart:io';

import '../../api/freelancer_api.dart';
import '../../models/_User.dart';
import '../../models/freelancer.dart';
import 'userService.dart';

class FreelancerService {
  var api = FreelancerApi();
  var user = UserService();

  Future<Freelancer> getUser(int id) async {
    var r = await api.getById(id);
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      return Freelancer.fromJson(data);
    } else {
      return Freelancer.empty();
    }
  }

  Future<List<Freelancer>> getAllFreelancers() async {
    var liste = <Freelancer>[];
    var r = await api.getAll();
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for (var i in data) {
        liste.add(Freelancer.fromJson(i));
      }
      return liste;
    } else {
      return [];
    }
  }

  Future<List<Freelancer>> getMostPopular() async {
    var liste = <Freelancer>[];
    var r = await api.getMostPopularFreelancers();
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for (var i in data) {
        liste.add(Freelancer.fromJson(i));
      }
      return liste;
    } else {
      return [];
    }
  }

  Future<void> imageUpdate(File file) async {
    Users u = await user.getUser();
    var r = await api.imageUpdate(file ,u);
    if(r.statusCode == 200){
      print("Tmm");
    }else{
      print("Hata");
    }
  }
}
