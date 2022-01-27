
class Login{
  late String username;
  late String password;

  Login(this.username, this.password);

  Map toJson(){
    return {
      "userName":username,
      "password":password
    };
  }
}