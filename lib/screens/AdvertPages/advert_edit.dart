
// ignore_for_file: prefer_const_constructors, must_be_immutable, camel_case_types, no_logic_in_create_state, prefer_final_fields, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/advert.dart';
import '../Components/TopBar.dart';

class AdvertEdit extends StatefulWidget {
  AdvertEdit({Key? key, required this.advert}) : super(key: key);
  Advert advert;

  @override
  State<StatefulWidget> createState() => _advertEdit(advert);
}

class _advertEdit extends State {
  _advertEdit(this.advert);
  Advert advert;

  var _picker = ImagePicker();
  File file = File("");

  getImage() async {
    final XFile? selectedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    file = File(selectedFile!.path);
    advert.image_path = file.path;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(),
            //Title(),
            const SizedBox(height: 10),
            Image(),
            const SizedBox(
              height: 10,
            ),
            textData("Başlık"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xfff4f5f7), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xfff4f5f7), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: advert.title,
                  //labelText:"Başlık",
                  labelStyle:
                      const TextStyle(fontSize: 16, color: Color(0xffe83c5f)),
                  fillColor: const Color(0xfff4f5f7),
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            textData("Açıklama"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xfff4f5f7), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xfff4f5f7), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: advert.info,
                  //labelText:"Açıklama",
                  labelStyle:
                      const TextStyle(fontSize: 16, color: Color(0xffe83c5f)),
                  fillColor: const Color(0xfff4f5f7),
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            textData("Fiyat"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xfff4f5f7), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xfff4f5f7), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: advert.price.toString(),
                  //labelText:"Fiyat",
                  labelStyle:
                      const TextStyle(fontSize: 16, color: Color(0xffe83c5f)),
                  fillColor: const Color(0xfff4f5f7),
                  filled: true,
                ),
              ),
            ),
            Center(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("Güncelle",
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding textData(String data) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Text(data, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget Image() {
    if (file.path != "") {
      return Stack(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage(""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                icon: const Icon(Icons.edit),
                iconSize: 35,
                color: const Color(0xffe83c5f),
                onPressed: () {
                  getImage();
                }),
          ),
        ),
      ]);
    } else {
      return Stack(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage(
                    advert.image_path,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                icon: const Icon(Icons.edit),
                iconSize: 35,
                color: const Color(0xffe83c5f),
                onPressed: () {
                  getImage();
                }),
          ),
        ),
      ]);
    }
  }
}
