// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, unused_local_variable, must_call_super, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../models/sub_category.dart';
import '../../models/top_category.dart';
import '../../service/category/subCategoryService.dart';
import '../../service/category/topCategoryService.dart';
import '../Components/TopBar.dart';

class AddAdvert extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addAdvertState();
}

class _addAdvertState extends State {

  var sevriceTopCat = TopCategoryService();
  var serviceSubCat = SubCategoryService();

  String _topCat = "";
  String _subCat = "";
  List<String> topCategories = ["Seçiniz"];
  List<TopCategory> topCats = [];
  List<SubCategory> subCats = [];
  List<String> subCategories = ["Seçiniz"];

  @override
  initState() {
    _veriGetir();
    _topCat = "Seçiniz";
    _subCat = "Seçiniz";
  }

  _veriGetir() async {
    topCats = await sevriceTopCat.getAll();
    for (var i = 0; i < topCats.length; i++){
      topCategories.add(topCats[i].name);
    }
    setState((){});
  }

  getSubCat() async {
    int index = -10;
    for(var i=0;i< topCats.length;i++){
      if(_topCat == topCats[i].name){
        index = topCats[i].id;
      }
    }
    subCats = await serviceSubCat.getAll(index);
    List<String> temp = ["Seçiniz"];
    for(var i=0;i< subCats.length;i++){
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
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText:"Ben ... iyi yaparım.",
                  //labelText:"Açıklama",
                  labelStyle: const TextStyle(fontSize:16, color:Color(0xffe83c5f)),
                  fillColor:const Color(0xfff4f5f7),
                  filled: true,
                ),
              ),
            ),
            SizedBox(height:10),
            textData("Açıklama"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText:"Daha önce de yapmıştım ...",
                  //labelText:"Açıklama",
                  labelStyle: const TextStyle(fontSize:16, color:Color(0xffe83c5f)),
                  fillColor:const Color(0xfff4f5f7),
                  filled: true,
                ),
              ),
            ),
            SizedBox(height:10),
            textData("Fiyat"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText:"Fiyat",
                  //labelText:"Açıklama",
                  labelStyle: const TextStyle(fontSize:16, color:Color(0xffe83c5f)),
                  fillColor:const Color(0xfff4f5f7),
                  filled: true,
                ),
              ),
            ),
            // RESIM EKLENECEK
            Center(
              child: OutlinedButton(
                onPressed:(){},
                child:const Text("Yayınla" , style:TextStyle(fontSize:18,)),
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
    return Stack(
      children: [
        Center(
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Container(
                height: MediaQuery.of(context).size.height/3,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  image:DecorationImage(
                    image:NetworkImage(
                      "https://avatars.githubusercontent.com/u/42716195?v=4",
                    ),
                    fit:BoxFit.cover,
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
                icon:const Icon(Icons.edit),
                iconSize: 35,
                color:const Color(0xffe83c5f),
                onPressed: () {}
              ),
            ),
          ),
      ]
    );
  }
}
