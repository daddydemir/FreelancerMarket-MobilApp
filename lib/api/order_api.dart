import 'dart:convert';
import 'dart:io';
import 'package:freelancer_market/models/advert.dart';
import 'package:http/http.dart' as http;

import '../models/_User.dart';
import '../models/order.dart';
class OrderApi{

  // yeni backend çalışmıyor.
  Future add(Advert advert,Users user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/add");
    return await http.post(
      url,
      headers:{
        "Content-Type": "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
      body:jsonEncode(<String,dynamic>{
        "advertId":advert.id,
        "userId":user.id,
      }),
    );
  }

  // eksik -> neyin id'sini istiyor emin değilim. : orderId sanırım.
  // onaylama işlemi sipariş veren kişiye hizmet edildiği takdirde ödeme yapan kişi onaylar ve para freelancera geçer
  // bunu neden bu kadar geç anladım ben yaa 
  Future confirm(Users user, Order order) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/confirm?id="+order.id.toString());
    return await http.post(
      url,
      headers:{
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      },
    );
  }

  Future getAll(Users user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/getAll");
    return await http.get(
      url,
      headers:{
        //HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }
  
  Future getByFreelancerId(Users user) async{
    var url = Uri.parse("https://freelancer-market-backend.herokuapp.com/api/orders/getByFreelancerId?id=" + user.id.toString());
    return await http.get(
      url,
    );
  }

  // eski backend çalışıyor sadece
  Future getByUserId(Users user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/orders/getByUserId?id="+user.id.toString());
    return await http.get(
      url,
      headers:{
        //HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }
}