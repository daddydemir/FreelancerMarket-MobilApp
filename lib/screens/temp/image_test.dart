// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, camel_case_types, prefer_const_constructors, avoid_print, unused_local_variable, unnecessary_null_comparison, prefer_collection_literals
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../service/user/userService.dart';

class ImageTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _imageTest();
}

class _imageTest extends State {
  //
  var service = UserService();
  late File file;
  String data = "hata";

  getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? selectedfile =
        await _picker.pickImage(source: ImageSource.gallery);
    file = File(selectedfile!.path);
    setState(() {});
  }

  uploadImage2() async {
    var dio = Dio();
    var map = Map<String,dynamic>();
    map["file"] = await MultipartFile.fromFile(file.path, filename: 'images.jpeg');
    dio.options.headers["Authorization"] = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkZW1pciIsImV4cCI6MTY1MzIzODA4MCwiaWF0IjoxNjUzMjIwMDgwfQ.SuN15-OeH4FwX9NreEkjxiPDEkmBJ3n39qDSw4LVF9pA2EJqA5Xsb-EROcV5u1GAgF_eHaaMXrX944pvehPLtQ";

    var formData = FormData.fromMap(map);
    var response = await dio.post('https://freelancer-market-backend.herokuapp.com/api/freelancers/imageUpdate?id=23',data:formData);
    print(response.statusCode.toString());
  }

  

  uploadImage() async {
    var request = http.MultipartRequest('POST',Uri.parse("https://freelancer-market-backend.herokuapp.com/api/freelancers/imageUpdate?id=23"));
    request.files.add(http.MultipartFile.fromBytes(
        "file", File(file.path).readAsBytesSync(),filename: file.path , contentType:MediaType("image","jpg")));
    print("Filename:" + file.path);
    var user = await service.getUser();
    print("TOKEN : " + user.token);
    request.headers["authorization"] = "Bearer " + user.token;
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    print("KOD : " +res.statusCode.toString() +json.decode(utf8.decode(response.bodyBytes)).toString());
    data = json.decode(utf8.decode(response.bodyBytes)).toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image Demo"),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                getImage();
              },
              child: Text('Choose Image'),
            ),
            SizedBox(
              height: 20.0,
            ),
            //showImage(),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                uploadImage();
              },
              child: Text('Upload Image'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Image.file(
              file,
              height: 250,
              fit: BoxFit.cover,
            ),
            Text(
              data,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
