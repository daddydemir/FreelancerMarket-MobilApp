// ignore_for_file: avoid_print, file_names

import 'dart:convert';

import 'package:freelancer_market/service/user/userService.dart';

import '../api/Advert-comment.dart';
import '../models/advert.dart';
import '../models/commentResponse.dart';
import '../models/comments.dart';
import '../models/user.dart';

class CommentService{

 var api = AdvertCommentApi(); 
 var us = UserService();

 Future<bool> yorumYanitlama(String yorum, Comments comment) async {
   var r = await api.commentResponseAdd(comment, await us.getUser(), yorum);
   if(r.statusCode == 200){
     print("Eklendi");
     return true;
   }else{
     print("Hata");
     return false;
   }
 }

 Future<List> getByAdvertId(Advert advert) async {
   var list = <Comments>[];
   var responselist = <CommentResponse>[];
   var userlist = <User>[];

   var r = await api.getByAdvertId(advert);
   if(r.statusCode == 200){
     var data = json.decode(utf8.decode(r.bodyBytes));
      data = data['data'];
      for(var i in data){
        list.add(Comments.fromJson(i));
        userlist.add(User.forCommentsFromJson(i["user"]));
        if(i["advertCommentResponses"] != null){
          for(var m in i["advertCommentResponses"]){
          responselist.add(CommentResponse.fromJson(m));
        }
        }
      }
      return [list , userlist , responselist];
   }else{
     print(r.statusCode.toString());
     return [list , userlist, responselist];
   }
 }
}