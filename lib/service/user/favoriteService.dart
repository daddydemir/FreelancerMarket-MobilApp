
import 'dart:convert';

import 'package:freelancer_market/service/user/userService.dart';

import '../../api/favorite_api.dart';
import '../../models/_User.dart';

class FavoriteService{

  var api = FavoriteApi();
  

  Future<void> add(int index) async{
    Users user = await UserService().getUser();
    var r = await api.add(index ,user);
    if(r.statusCode == 200){
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data["data"];
      print(data);
    }else{
      print("Code : " + r.statusCode.toString());
      print(json.decode(utf8.decode(r.bodyBytes)));
    }
  }

  Future<void> delete(int index)async{
    Users user = await UserService().getUser();
    var r = await api.delete(index ,user);
    if(r.statusCode == 200){
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data["data"];
      print(data);
    }else{
      print("Code : " + r.statusCode.toString());
    }
  }
}