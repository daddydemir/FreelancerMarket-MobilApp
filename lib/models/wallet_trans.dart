
class WalletTrans{

  late int id;
  late String transName;
  late double amount;
  late String date;

  WalletTrans.fromJson(Map m){
    id = m["id"];
    transName = m["transactionName"];
    amount = m["amount"];
    date = m["date"];
  }
}