import 'dart:convert';
import 'dart:io';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:freelancer_market/models/sub_category.dart';
import 'package:freelancer_market/models/top_category.dart';
import 'package:http/http.dart' as http;
class SubCategoryApi{

  static Future add(SqlUser user,TopCategory topCategory, var newCategory) async {
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/subCategories/add");
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body:jsonEncode(<String, String>{
        "topCategoryId":topCategory.id.toString(),
        "name": newCategory,
      })
    );
  }

  // güncelleme gerekebilir
  static Future delete(SqlUser user,SubCategory subCategory) async {
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/subCategories/delete?id="+subCategory.id.toString());
    return await http.delete(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
    );
  }

  Future getAll() async {
    var url = Uri.parse("http://freelancermarket-backend.herokuapp.com/api/subCategories/getAll");
    return await http.get(url);
  }

  Future getByTopCategoryId(int topCategory) async {
    var url = Uri.parse("http://freelancermarket-backend.herokuapp.com/api/subCategories/getByTopCategoryId?id="+topCategory.toString());
    return await http.get(url);
  }

  Future getMostPopularSubCategories() async {
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/subCategories/getMostPopularSubCategories");
    return await http.get(url);
  }
}