// ignore_for_file: file_names

import '../../data/databaseHelper.dart';

class LogoutService{
  
  var db = DatabaseHelper();

  void logout() async {
    var userList = await db.getUsers();
    await db.delete(userList[0].id);
  }
}