// ignore_for_file: file_names

import '../../data/databaseHelper.dart';
import '../../models/_User.dart';

class UserService{

  Future<Users> getUser() async{
    var db = DatabaseHelper();
    var list =  await db.getUsers();
    if(list.isEmpty){
      return Users.empty();
    }
    else{
      return list[0];
    }
  }
}