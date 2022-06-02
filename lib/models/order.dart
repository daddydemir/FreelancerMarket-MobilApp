
class Order{
  late int id;
  late int advertId;
  late int userId;
  late bool status;
  late String createdDate;
  late double price;

  Order.isEmpty();

  Order.fromJson(Map json) {
    id = json["id"];
    advertId = json["advertId"];
    userId = json["userId"];
    status = json["status"];
    createdDate = json["createdDate"];
    price = json["price"];
  }
}