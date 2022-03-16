import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'imageController.dart';

class ImageUpload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _imageUpload();
}

class _imageUpload extends State {
  var controller = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 40,
            ),
          ],
        ),
        child: SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return CircleAvatar(
                    backgroundImage: AssetImage('/assets/logo.png'),
                    child: Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )),
                  );
                } else {
                  if (controller.imageURL.length != 0) {
                    return CachedNetworkImage(
                      imageUrl: controller.imageURL,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => CircleAvatar(
                        backgroundImage: AssetImage('/assets/logo.png'),
                        child: Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    );
                  } else {
                    return CircleAvatar(
                      backgroundImage: AssetImage('/assets/logo.png'),
                    );
                  }
                }
              }),
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Colors.white),
                    ),
                    color: Colors.grey[200],
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0)),
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              ListTile(
                                leading: Icon(Icons.camera),
                                title: Text('Camera'),
                                onTap: () {
                                  Get.back();
                                  controller.uploadImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.image),
                                title: Text('Gallery'),
                                onTap: () {
                                  Get.back();
                                  controller.uploadImage(ImageSource.gallery);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Image(
                      image: NetworkImage("https://cdn.pixabay.com/photo/2020/12/07/18/24/eagle-5812500_960_720.jpg"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
