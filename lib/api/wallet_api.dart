import 'dart:io';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:http/http.dart' as http;
class WalletApi{

  static Future getByUserId(SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/wallets/getByUserId?userId="+user.id.toString());
    return await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }

  static Future walletTransactionsGetByUserId(SqlUser user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/walletTransactions/getByUserId?userId="+user.id.toString());
    return await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }
}