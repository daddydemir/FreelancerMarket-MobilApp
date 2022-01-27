
class User{
  late int id;
  late String name;
  late String surname;
  late String username;
  late String email;
  late String password;

  

  User.forLocalDb(this.name, this.surname, this.username, this.email, this.password);
  User.forLocalDbWithId(this.id, this.name, this.surname, this.username, this.email, this.password);
  /*
  * Local db ye  kaydederken kullanılacak const
  */
  User.login(this.username , this.password);

  Map toLogin(){
    return{
      "userName":username,
      "password":password
    };
  }

  Map<String,dynamic> toMap(){
    return{
      "id":id,
      "name":name,
      "surname":surname,
      "username":username,
      "email":email,
      "password":password
    };
  }

  Map<String,dynamic> toSqlMap(){
    var m1;
    m1["username"]=username;
    m1["password"]=password;
    return m1;
  }
}