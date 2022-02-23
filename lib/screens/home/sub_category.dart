import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/sub_category_api.dart';
import 'package:freelancer_market/models/sub_category.dart';
import 'package:freelancer_market/screens/AdvertPages/sub_category_id_for_advert.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _subCategoryPageState(index);
}

// ignore: camel_case_types
class _subCategoryPageState extends State {
  _subCategoryPageState(this.index);
  final int index;
  int durum = 0;
  List<SubCategory> kategoriler = [];

  Future<void> _veriGetir() async {
    var gelen = await SubCategoryApi.getByTopCategoryId(index);
    if (gelen.statusCode == 200) {
      var cevap = json.decode(utf8.decode(gelen.bodyBytes));
      var data = cevap["data"];
      for (var i in data) {
        kategoriler.add(SubCategory(
            i["id"], i["topCategoryId"], i["name"], i["imagePath"]));
        setState(() {});
      }
    } else {
      durum = gelen.statusCode;
    }
  }

  @override
  void initState() {
    //getCategories();
    _veriGetir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff4f5f7),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: ListView.builder(
                itemCount: kategoriler.length,
                itemBuilder: (context, index) {
                  return item(kategoriler[index]);
                }),
          ),
        ));
  }

  Padding item(var data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: const Color(0xffe83c5f),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black,
        elevation: 20,
        child: InkWell(
          onTap: () {
            print("Sub Category : " + data.name);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubCategoryIdForAdvertPage(index: data.id),
                ),
              );
          },
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(data.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data.name,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff201a3d))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
