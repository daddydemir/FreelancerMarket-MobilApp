// ignore_for_file: file_names

class Users {
  late int id;
  late String username;
  late String name;
  late String surname;
  late String mail;
  late String image;
  late String token;
  late String role;

  Users.empty();

  Users(
      {required this.id,
      required this.username,
      required this.name,
      required this.surname,
      required this.mail,
      required this.image,
      required this.token,
      required this.role});

  Users.fromObject(dynamic d) {
    id = d['id'];
    username = d['username'];
    name = d['name'];
    surname = d['surname'];
    mail = d['mail'];
    image = d['image'];
    token = d['token'];
    role = d['role'];
  }

  Users.fromJson(Map m) {
    token = m['jwtToken'];
    m = m["user"];
    id = m["id"];
    username = m["userName"];
    name = m["name"];
    surname = m["surName"];
    image = m["imagePath"];
    mail = m["email"];
    var k = m["operationClaims"];
    print(k.toString());
    role = k[0]['claimName'];
  }
}