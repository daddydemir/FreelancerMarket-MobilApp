

class Freelancer {
  late int userId;
  late String username;
  late String appellation;
  late String imagePath;
  // şimdiye kadarkiler ilanlar ile birlikte gösterilecek verilerdi.
  late String name;
  late String surname;
  late int tamamlananSiparis;
  late DateTime createdDate;

  // ilanlar'da görüntülenecek bilgileri tutacak
  Freelancer.forAdvert(this.userId, this.username, this.appellation, this.imagePath);
} 