// ignore_for_file: file_names

import 'dart:convert';

import 'package:freelancer_market/data/databaseHelper.dart';

import '../../api/auth_api.dart';
import '../../models/_User.dart';

class LoginService {
  var api = AuthApi();
  var db = DatabaseHelper();

  Future<bool> login(var username, var password) async {
    var response = await api.login(username, password);
    if(response.statusCode == 200){
       var r = json.decode(utf8.decode(response.bodyBytes));
        var user = Users.fromJson(r['data']);
        await db.insert(user);
      return true;
    }else{
      return false;
    }
  }

  Future changePassword(var oldPass, var newPass, var rePass) async {
    var users = await db.getUsers();
    var r = await api.changePassword(users[0], oldPass, newPass, rePass);

    var data = json.decode(utf8.decode(r.bodyBytes));
    data = data['message'];
    return [r.statusCode , data];
  }
}
