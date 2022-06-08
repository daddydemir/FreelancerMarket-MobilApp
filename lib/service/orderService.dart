// ignore_for_file: avoid_print, file_names, non_constant_identifier_names

import 'dart:convert';

import '../api/order_api.dart';
import '../models/_User.dart';
import '../models/advert.dart';
import '../models/order.dart';
import 'user/userService.dart';

class OrderService{
  var api = OrderApi();
  var user = UserService();

  Future<bool> SiparisOnay(Order id) async {
    var r = await api.confirm(await user.getUser(), id);
     print(json.decode(utf8.decode(r.bodyBytes)));
    if(r.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

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

  // freelancer'lar ilanları onaylayabilcekleri sayfa 
  Future<List> getOrderFreelancerId() async {
    List<Order> orderlist = [];
    List<Users> userlist = [];
    List<Advert> advertlist = [];

    var r = await api.getByFreelancerId(await user.getUser());
    Map data = json.decode(utf8.decode(r.bodyBytes));
    
    
    print("VERI :" + data.toString());
    if(r.statusCode == 200){
      for(Map i in data['data']){
        orderlist.add(Order.fromJson(i));
        advertlist.add(Advert.fromJson(i['advert']));
        if(i['user'] != null){
          userlist.add(Users.fromJson(i));
        }  
      }
      return [orderlist , userlist , advertlist];
    }else{
      return [];
    }
  }

  Future<List> orderGet() async {

    List<Order> orderlist = [];
    List<Users> userlist = [];
    List<Advert> advertlist = [];

    var r = await api.getAll(await user.getUser());
    var data = json.decode(utf8.decode(r.bodyBytes));
    
    data = data['data'];
    if(r.statusCode == 200){
      for(var i in data){
        orderlist.add(Order.fromJson(i));
        advertlist.add(Advert.fromJson(i['advert']));
        userlist.add(Users.fromJson(i['user']));      
      }
      return [orderlist , userlist , advertlist];
    }else{
      return [];
    }
  }
}