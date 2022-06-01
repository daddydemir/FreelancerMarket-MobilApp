import 'dart:convert';

import '../api/Advert-comment.dart';
import '../models/advert.dart';
import '../models/commentResponse.dart';
import '../models/comments.dart';
import '../models/user.dart';

class CommentService{

 var api = AdvertCommentApi(); 

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