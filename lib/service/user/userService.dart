
import '../../data/databaseHelper.dart';
import '../../models/_User.dart';

class UserService{

  Future<Users> getUser() async{
    var db = DatabaseHelper();
    var list =  await db.getUsers();
    return list[0];
  }
}