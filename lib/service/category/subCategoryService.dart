// ignore_for_file: file_names

import 'dart:convert';

import '../../api/sub_category_api.dart';
import '../../models/sub_category.dart';

class SubCategoryService {
  var api = SubCategoryApi();

  Future<List<SubCategory>> getAll(int id) async {
    var liste = <SubCategory>[];
    var r = await api.getByTopCategoryId(id);
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for (var i in data) {
        liste.add(SubCategory.fromJson(i));
      }
      return liste;
    } else {
      return [];
    }
  }

  Future<List<SubCategory>> getMostPopular() async {
    var liste = <SubCategory>[];
    var r = await api.getMostPopularSubCategories();
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for (var i in data) {
        liste.add(SubCategory.fromJson(i));
      }
      return liste;
    } else {
      return [];
    }
  }
}
