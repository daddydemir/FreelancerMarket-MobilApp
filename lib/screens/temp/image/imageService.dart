// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/databaseHelper.dart';

class ImageService{

  var db = DatabaseHelper();
  


  Future getUser() async {
    return await db.getUsers();
  }

  static Future<dynamic> uploadFile(filepath) async{
    try{
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filepath,filename: "randomname"),
      });
       Response response = await Dio().post(
         "https://freelancermarket-backend.herokuapp.com/api/freelancers/imageUpdate?id=23",
         data:formData,
         options:Options(
           headers:{
             'Authorization' : "Bearer " + "tokenyazılacak"
           }
         ),
       );
       return response;
    }on DioError catch(e){
      return e.response;
    }catch(e){
      // nothing
    }

  }
}