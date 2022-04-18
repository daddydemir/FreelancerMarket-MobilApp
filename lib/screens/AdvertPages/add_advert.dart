// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';

import '../Components/TopBar.dart';

class AddAdvert extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addAdvertState();
}

class _addAdvertState extends State {
  String _value2 = "";
  List<String> nameList = [];
  @override
  initState() {
    super.initState();
    _value2 = "One";
    nameList = ["Test1", "Test2", "Test3"];
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
                  value: _value2,
                  onChanged: (String? value) {
                    setState(() {
                      _value2 = value!;
                    });
                  },
                  items: ['One', 'Two', 'Free', 'Four'].map(
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
                  value: _value2,
                  onChanged: (String? value) {
                    setState(() {
                      _value2 = value!;
                    });
                  },
                  items: ['One', 'Two', 'Free', 'Four'].map(
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
}
