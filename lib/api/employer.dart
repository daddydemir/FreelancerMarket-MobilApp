import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
class EmployerApi{

  static Future getAll() async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/employers/getAll");
    return await http.get(url);
  }

  static Future getById(var id) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/employers/getById?id"+id);
    return await http.get(url);
  }

}