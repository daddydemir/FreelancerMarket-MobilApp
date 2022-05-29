// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, unused_local_variable, must_call_super, avoid_print, non_constant_identifier_names, prefer_final_fields, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/advert.dart';
import '../../models/sub_category.dart';
import '../../models/top_category.dart';
import '../../service/advert/advertService.dart';
import '../../service/category/subCategoryService.dart';
import '../../service/category/topCategoryService.dart';
import '../Components/TopBar.dart';

class AddAdvert extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addAdvertState();
}

class _addAdvertState extends State {
  var service = AdvertService();
  var _picker = ImagePicker();
  File file = File("");

  var sevriceTopCat = TopCategoryService();
  var serviceSubCat = SubCategoryService();

  String _topCat = "";
  String _subCat = "";
  List<String> topCategories = ["Seçiniz"];
  List<TopCategory> topCats = [];
  List<SubCategory> subCats = [];
  List<String> subCategories = ["Seçiniz"];

  var title = TextEditingController();
  var info = TextEditingController();
  var price = TextEditingController();

  getImage() async {
    final XFile? selectedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    file = File(selectedFile!.path);
    setState(() {});
  }

  @override
  initState() {
    _veriGetir();
    _topCat = "Seçiniz";
    _subCat = "Seçiniz";
  }

  _veriGetir() async {
    topCats = await sevriceTopCat.getAll();
    for (var i = 0; i < topCats.length; i++) {
      topCategories.add(topCats[i].name);
    }
    setState(() {});
  }

  getSubCat() async {
    int index = -10;
    for (var i = 0; i < topCats.length; i++) {
      if (_topCat == topCats[i].name) {
        index = topCats[i].id;
      }
    }
    subCats = await serviceSubCat.getAll(index);
    List<String> temp = ["Seçiniz"];
    for (var i = 0; i < subCats.length; i++) {
      temp.add(subCats[i].name);
      print(subCats[i].name);
    }
    subCategories = temp;
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
            const SizedBox(height: 10),
            Image(),
            const SizedBox(height: 10),
            textData("Üst Kategori"),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField(
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
                    fillColor: const Color(0xfff4f5f7),
                    filled: true,
                  ),
                  isExpanded: true,
                  elevation: 12,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  borderRadius: BorderRadius.circular(25),
                  value: _topCat,
                  onChanged: (String? value) {
                    setState(() {
                      _topCat = value!;
                      getSubCat();
                    });
                  },
                  items: topCategories.map(
                    (item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            textData("Alt Kategori"),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField(
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
                    fillColor: const Color(0xfff4f5f7),
                    filled: true,
                  ),
                  isExpanded: true,
                  elevation: 12,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  borderRadius: BorderRadius.circular(25),
                  value: _subCat,
                  onChanged: (String? value) {
                    setState(() {
                      _subCat = value!;
                    });
                  },
                  items: subCategories.map(
                    (item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            textData("Başlık"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: title,
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
                  hintText: "Ben ... iyi yaparım.",
                  //labelText:"Açıklama",
                  labelStyle:
                      const TextStyle(fontSize: 16, color: Color(0xffe83c5f)),
                  fillColor: const Color(0xfff4f5f7),
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 10),
            textData("Açıklama"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: info,
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
                  hintText: "Daha önce de yapmıştım ...",
                  //labelText:"Açıklama",
                  labelStyle:
                      const TextStyle(fontSize: 16, color: Color(0xffe83c5f)),
                  fillColor: const Color(0xfff4f5f7),
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 10),
            textData("Fiyat"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: price,
                maxLines: null,
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
                  hintText: "Fiyat",
                  //labelText:"Açıklama",
                  labelStyle:
                      const TextStyle(fontSize: 16, color: Color(0xffe83c5f)),
                  fillColor: const Color(0xfff4f5f7),
                  filled: true,
                ),
              ),
            ),
            // RESIM EKLENECEK
            Center(
              child: OutlinedButton(
                onPressed: () {
                  save();
                },
                child: const Text("Yayınla",
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
      padding: const EdgeInsets.only(left: 14, bottom: 5),
      child: Text(data, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget Image() {
    if (file.path != "") {
      return Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: FileImage(file),
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
        ],
      );
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
                    "https://avatars.githubusercontent.com/u/42716195?v=4",
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

  void save() async {
    Advert advert = Advert.empty();
    advert.title = title.text;
    advert.price = double.parse(price.text);
    advert.info = info.text;
    int subId = 0;
    for (int i = 0; i < subCats.length; i++) {
      if (subCats[i].name == _subCat) {
        subId = subCats[i].id;
      }
    }
    advert.sub_category_id = subId;
    var response = false;
    response = await service.Add(file, advert);
    final snackbar;
    if (response) {
      snackbar = SnackBar(backgroundColor: Colors.greenAccent,content: Text("Başarıyla eklendi."));
    } else {
      snackbar = SnackBar(content:Text("Ekleme başarısız oldu."), backgroundColor: Colors.redAccent,);
    }
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
