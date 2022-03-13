class Freelancer {
  late int id;
  late String name;
  late String surname;
  late String username;
  late String email;
  late String appellation;
  late String imagePath;
  late String about;
  late double average;

  Freelancer.empty();

  Freelancer(
      {required this.id,
      required this.name,
      required this.surname,
      required this.username,
      required this.email,
      required this.appellation,
      required this.imagePath,
      required this.about,
      required this.average});

  Freelancer.forAdvert(Map map) {
    id = map["id"];
    username = map["userName"];
    appellation = map["appellation"];
    imagePath = map["imagePath"];
  }

  Freelancer.fromJson(Map map) {
    id = map["id"];
    name = map["name"];
    surname = map["surName"];
    username = map["userName"];
    email = map["email"];
    appellation = map["appellation"] ?? "nobody";
    imagePath = map["imagePath"];
    about = map["about"] ?? " null ";
    average = map["averageScore"];
  }
}
