
// ignore_for_file: avoid_print

import 'dart:convert';

import '../api/order_api.dart';
import '../models/_User.dart';
import '../models/advert.dart';
import '../models/freelancer.dart';
import '../models/order.dart';
import 'user/userService.dart';

class OrderService{
  var api = OrderApi();
  var user = UserService();

  Future<bool> orderAdd(Advert advert,) async {
    var r = await api.add(advert, await user.getUser());
    print(json.decode(utf8.decode(r.bodyBytes)));
    if(r.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }

  Future<List> orderGet() async {

    List<Order> orderlist = [];
    List<Freelancer> userlist = [];
    List<Advert> advertlist = [];

    var r = await api.getAll(await user.getUser());
    var data = json.decode(utf8.decode(r.bodyBytes));
    
    data = data['data'];
    if(r.statusCode == 200){
      for(var i in data){
        orderlist.add(Order.fromJson(i));
        advertlist.add(Advert.fromJson(i['advert']));
        userlist.add(Freelancer.fromJson(i['advert']['freelancer']));      
      }
      return [orderlist , userlist , advertlist];
    }else{
      return [];
    }
  }
}