import 'dart:convert';

import '../../api/advert_api.dart';
import '../../models/advert.dart';

class AdvertService {
  var api = AdvertApi();

  Future<List<Advert>> getBySubCategoryId(int id) async {
    var liste = <Advert>[];
    var r = await api.getBySubCategoryId(id);
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for (var i in data) {
        liste.add(Advert.fromJson(i));
      }
      return liste;
    } else {
      return [];
    }
  }

  Future<List<Advert>> getMostPopular() async {
    var liste = <Advert>[];
    var r = await api.getMostPopularAdverts();
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for (var i in data) {
        liste.add(Advert.fromJson(i));
      }
      return liste;
    } else {
      return [];
    }
  }
}
