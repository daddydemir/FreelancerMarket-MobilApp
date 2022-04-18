import 'package:http/http.dart' as http;
class EmployerApi{

  static Future getAll() async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/employers/getAll");
    return await http.get(url);
  }

  Future getById(int id) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/employers/getById?id="+id.toString());
    return await http.get(url);
  }

}