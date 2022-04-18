class Employer {
  late int id;
  late String name;
  late String surname;
  late String username;
  late String email;
  late String imagePath;
  late String about;

  Employer.empty();

  Employer(
      {required this.id,
      required this.name,
      required this.surname,
      required this.username,
      required this.email,
      required this.imagePath,
      required this.about});

  Employer.fromJson(Map map) {
    id = map["id"];
    name = map["name"];
    surname = map["surName"];
    username = map["userName"];
    email = map["email"];
    imagePath = map["imagePath"];
    about = map["about"] ?? "bu kullanıcı hakkında bir şey bilmiyoruz :(";
  }
}
