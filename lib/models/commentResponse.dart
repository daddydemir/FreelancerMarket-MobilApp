// ignore_for_file: file_names

class CommentResponse{

  late int id;
  late int userId;
  late String content;
  late String date;
  late int advertCommentId;

  CommentResponse(this.id, this.userId, this.content, this.date, this.advertCommentId);

  CommentResponse.fromJson(Map json){
    id = json["id"];
    userId = json["userId"];
    content = json["content"];
    date = json["date"];
    advertCommentId = json["advertCommentId"];
  }
}