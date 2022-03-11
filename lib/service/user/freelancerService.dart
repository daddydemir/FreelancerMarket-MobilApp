
import 'dart:convert';

import '../../api/freelancer_api.dart';
import '../../models/freelancer.dart';

class FreelancerService{
  var api = FreelancerApi();

  Future<Freelancer> getUser(int id) async{
    var r = await api.getById(id);
    if(r.statusCode == 200){
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      return Freelancer.fromJson(data);
    }else{
      return Freelancer.empty();
    }
  }
}