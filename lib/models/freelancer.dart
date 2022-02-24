

class Freelancer {
  late int id;
  late String name;
  late String surname;
  late String username;
  late String email;
  late String appellation;
  late String imagePath;
  // şimdiye kadarkiler ilanlar ile birlikte gösterilecek verilerdi.
  late double average;
  late int tamamlananSiparis;
  late String createdDate;

  Freelancer.forAdvert(Map map){
    id = map["id"];
    username = map["userName"];
    appellation = map["appellation"];
    imagePath = map["imagePath"];
  }

  Freelancer.fromJson(Map map){
    id= map["id"];
    name= map["name"];
    surname= map["surName"];
    username= map["userName"];
    email= map["email"];
    appellation= map["appellation"];
    imagePath= map["imagePath"];
    average= map["averageScore"];
    //tamamlananSiparis= map["tamamamlan"] ? 0 : 0;
    //createdDate = map["createdDate"]? "boş" : "boş";
  }
} 