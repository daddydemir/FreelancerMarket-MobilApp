// ignore_for_file: unused_local_variable, unnecessary_new



class Comments {
  late int id;
  late int userId;
  late String content;
  late String date;

  Comments(this.id, this.userId, this.content, this.date);

  Comments.fromJson(Map json) {
    id = json["id"];
    userId = json["userId"];
    content = json["content"];
    date = json["date"];
  }
}
