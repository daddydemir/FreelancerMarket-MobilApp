class SqlUser{
  int? id;
  late String username;
  late String password;
  late String token;

  SqlUser.empty();
  SqlUser(this.id ,this.username, this.password);
  SqlUser.withId(this.id, this.username, this.password, this.token);

  Map<String, dynamic> toMap(){

    var map = Map<String, dynamic>();
    map["id"]=id;
    map["username"] = username;
    map["password"] = password;
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
    this.id = int.tryParse(o["id"].toString());
    this.username = o["username"];
    this.password = o["password"];
    this.token = o["token"];
    // bu kısımlaer çalışıyor . . .
  }

  SqlUser.fromMap(Map<String,Object?> map){
    id = int.tryParse(map["id"].toString());
    username = map["username"].toString();
    password = map["password"].toString();
    token = map["token"].toString();
  }
  String get_username(){
    return this.username;
  }
}