
import '../../data/databaseHelper.dart';
import '../../models/_User.dart';

class UserService{

  Future<Users> getUser() async{
    var db = DatabaseHelper();
    List<Users> liste = await db.getUsers();
    return liste[0];
  }
}