// ignore_for_file: file_names, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import '../../api/advert_api.dart';
import '../../models/_User.dart';
import '../../models/advert.dart';
import '../user/userService.dart';

class AdvertService {
  var api = AdvertApi();
  var user = UserService();

  Future<List<Advert>> getBySubCategoryId(int id) async {
    var liste = <Advert>[];
    var r = await api.getBySubCategoryId(id);
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for (var i in data) {
        liste.add(Advert.fromJson(i));
      }
      return liste;
    } else {
      return [];
    }
  }

  Future<List<Advert>> getMostPopular() async {
    var liste = <Advert>[];
    var r = await api.getMostPopularAdverts();
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for (var i in data) {
        liste.add(Advert.fromJson(i));
      }
      return liste;
    } else {
      return [];
    }
  }

  Future<List<Advert>> getAdvertByUserId(int userId) async {
    var liste = <Advert>[];
    var r = await api.getByFreelancerId(userId);
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for (var i in data) {
        liste.add(Advert.fromJson(i));
      }
      return liste;
    }else{
      return [];
    }
  }
  Future<List<Advert>> getByFilter(String data) async {
    var liste = <Advert>[];
    var r = await api.getByFilter(data);
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for (var i in data) {
        liste.add(Advert.fromJson(i));
      }
      return liste;
    }else{
      print(json.decode(utf8.decode(r.bodyBytes)));
      return [];
    }
  }

  Future<bool> Add(File file , Advert advert) async {
    var r = await api.Add(await user.getUser(), advert, file);
    if(r.statusCode == 200){
      print("Ekleme başarılı");
      print(json.decode(utf8.decode(r.bodyBytes)));
      return true;
    }else{
      print("Ekleme başarısız");
      print(json.decode(utf8.decode(r.bodyBytes)));
      return false;
    }
  }

  Future<void> update(Advert advert, File file) async {
    Users u = await user.getUser();
    var r = await api.Update(advert, file, u);
    if(r.statusCode == 200){
      print("TRUE : " + json.decode(utf8.decode(r.bodyBytes)));
    }else{
      print("FALSE :" +json.decode(utf8.decode(r.bodyBytes)));
    }
  }
}
