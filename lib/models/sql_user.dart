class SqlUser{
  int? id;
  late String username;
  late String password;
  late String name;
  late String surname;
  late String mail;
  late String image;
  late String token;

  SqlUser.empty();
  SqlUser(this.id ,this.username, this.password, this.name , this.surname, this.mail, this.image);
  SqlUser.withId(this.id, this.username, this.password, this.token);

  Map<String, dynamic> toMap(){

    var map = <String, dynamic>{};
    map["id"]=id;
    map["username"] = username;
    map["password"] = password;
    map["name"] = name;
    map["surname"] = surname;
    map["mail"] = mail;
    map["image"] = image;
    map["token"] = token;
    /*
    var map = <String , dynamic>{
      "id":id,
      "username":username,
      "password":password,
      "token":token
    };
    */
    return map;
  }

  SqlUser.fromObject(dynamic o){
    //print("amk : "+o["id"].toString());
    id = int.tryParse(o["id"].toString());
    username = o["username"];
    password = o["password"];
    name = o["name"];
    surname = o["surname"];
    mail = o["mail"];
    image = o["image"];
    token = o["token"];
    // bu kısımlaer çalışıyor . . .
  }

  SqlUser.fromMap(Map<String,Object?> map){
    id = int.tryParse(map["id"].toString());
    username = map["username"].toString();
    password = map["password"].toString();
    name = map["name"].toString();
    surname = map["surname"].toString();
    mail = map["mail"].toString();
    image = map["image"].toString();
    token = map["token"].toString();
  }
  // ignore: non_constant_identifier_names
  String get_username(){
    return username;
  }
}