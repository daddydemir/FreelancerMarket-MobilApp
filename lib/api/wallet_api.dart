import 'dart:io';
import 'package:freelancer_market/models/_User.dart';
import 'package:http/http.dart' as http;
class WalletApi{

  Future getByUserId(Users user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/wallets/getByUserId?userId="+user.id.toString());
    return await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }

  Future walletTransactionsGetByUserId(Users user) async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/walletTransactions/getByUserId?userId="+user.id.toString());
    return await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:"Bearer "+user.token,
      }
    );
  }
}