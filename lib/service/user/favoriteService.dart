// ignore_for_file: file_names

import 'dart:convert';

import 'package:freelancer_market/service/user/userService.dart';

import '../../api/favorite_api.dart';
import '../../models/_User.dart';
import '../../models/advert.dart';

class FavoriteService{

  var api = FavoriteApi();
  

  Future<bool> add(int index) async{
    Users user = await UserService().getUser();
    var r = await api.add(index ,user);
    if(r.statusCode == 200){
      //print("Add : " + json.decode(utf8.decode(r.bodyBytes)).toString());
      return true;
    }else{
      //print("Add Err" + json.decode(utf8.decode(r.bodyBytes)).toString());
      return false;
    }
  }

  Future<bool> delete(int index)async{
    Users user = await UserService().getUser();
    var r = await api.delete(index ,user);
    if(r.statusCode == 200){
      //print("Delete : " + json.decode(utf8.decode(r.bodyBytes)).toString());
      return true;
    }else{
      //print("Delete Err : " + json.decode(utf8.decode(r.bodyBytes)).toString());
      return false;
    }
  }

  Future<List<Advert>> getAll() async{
    var liste = <Advert>[];
    Users user = await UserService().getUser();
    var r = await api.getByUserId(user);
    if(r.statusCode == 200){
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
}