// ignore_for_file: file_names, deprecated_member_use

import 'package:freelancer_market/screens/temp/image/imageService.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController{

  var isLoading = false.obs;
  var imageURL = '';

  uploadImage(ImageSource imageSource) async{

    try{

      final pickedFile = await ImagePicker().getImage(source: imageSource);
      isLoading(true);

      if(pickedFile != null){
        var response = await ImageService.uploadFile(pickedFile.path);

        if(response.statusCode == 200){
          // image => file olabilir
          imageURL = response['usre']['image'];

          Get.snackbar("Success", "Resim yükeleme başarılı");

        }else if(response.statusCode == 401){
          Get.offAllNamed('/signup');
        }else{
          Get.snackbar("Fail", "Resim yükleme başarısız oldu");
        }
      }else{
        Get.snackbar("Fail", "Resim seçilmedi");
      }
    }finally{
      isLoading(false);
    }
  }

}