import 'dart:convert';

import 'package:freelancer_market/api/wallet_api.dart';

import '../../models/_User.dart';
import '../../models/wallet_trans.dart';

class WalletService {
  var api = WalletApi();

  Future getMoney(Users user) async {
    var r = await api.getByUserId(user);
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      print("VERİ : " + data.toString());
      return data['balance'];
    }else if(r.statusCode == 401) {
      print("yok");
    }
  }

  Future getTransaction(Users user) async {
    var liste = <WalletTrans>[];
    var r = await api.walletTransactionsGetByUserId(user);
    if (r.statusCode == 200) {
      var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for(var i in data){
        liste.add(WalletTrans.fromJson(i));
      }
      return liste;
    }
  }
}
