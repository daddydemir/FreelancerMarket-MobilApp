// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, deprecated_member_use, prefer_is_empty

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
            //overflow: Overflow.visible,
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return const CircleAvatar(
                    backgroundColor: Colors.yellow,
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
                      placeholder: (context, url) => const CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    );
                  } else {
                    return const CircleAvatar(
                      backgroundColor: Colors.blue,
                    );
                  }
                }
              }),
              Positioned(
                right: -15,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0)),
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Camera'),
                                onTap: () {
                                  Get.back();
                                  controller.uploadImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text('Gallery'),
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
                    child: const Icon(
                      Icons.add,
                      color: Colors.pink,
                      size: 35,
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
