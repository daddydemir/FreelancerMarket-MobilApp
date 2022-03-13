import 'dart:convert';

import '../../api/top_category_api.dart';
import '../../models/top_category.dart';

class TopCategoryService{

  var api = TopCategoryApi();

  Future<List<TopCategory>> getAll() async{
    var liste = <TopCategory>[];
    var r = await api.getAll();
    if(r.statusCode == 200){
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for(var i in data){
        liste.add(TopCategory.fromJson(i));
      }
      return liste;
    }else{
      return [];
    }
  }
}