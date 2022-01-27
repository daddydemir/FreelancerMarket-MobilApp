import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/top_category_api.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _mainPageState();
  }
}

// ignore: camel_case_types
class _mainPageState extends State {
  var api = TopCategoryApi();
  var categoryList = [
    "Yazılım & Teknoloji",
    "Grafik & Tasarım",
    "Ses & Müzik",
    "Yazı & Çeviri",
    "Video & Animasyon"
  ];
  var colorL = [
    0xffffbf00,0xff67c1d6,0xffff5159,0xff4b4f52,0xff3faa40,0xff4260e9
  ];
  int get li => categoryList.length;
  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f5f7),
      body: Column(children: [
        topMenu(),
        searchBar(),
        Expanded(
          child: SizedBox(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: li,
                itemBuilder: (context, index) {
                  return satir(colorL[index],categoryList[index]);
                }),
          ),
        ),
      ]),
    );
  }

  Center searchBar() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, top: 5.0, right: 10, bottom: 10),
          child: PhysicalModel(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            elevation: 20,
            shadowColor: Colors.black,
            child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xfffefefe), width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xfffefefe), width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Neye ihtiyacın var ?',
                  fillColor: const Color(0xfffefefe),
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      print("Ara bakalım");
                    },
                    icon: const Icon(Icons.search),
                    color: Colors.black,
                    iconSize: 30,
                  )),
            ),
          )),
    );
  }

  Row satir(var c,var a) {
    return Row(
      children: [
        kutu(c, a),
        kutu(c, a),
        // ff5159
      ],
    );
  }

  Expanded kutu(var a, String x) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 7, top: 7, right: 7),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Color(a),
        shadowColor: Colors.black,
        elevation: 20,
        child: InkWell(
          splashColor: Colors.blue,
          onTap: () {
            getCategories();
          },
          child: SizedBox(
            height: 200,
            child: Center(
              child: Text(
                x,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Padding topMenu() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        top: 20,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.network(
          "https://raw.githubusercontent.com/daddydemir/images/main/freelancer-market/PNG-4x/acik-zemin%404x.png",
          width: 200,
        ),
        IconButton(
          iconSize: 35,
          icon: const Icon(Icons.add_alert),
          tooltip: "Alert Message",
          color: const Color(0xfffac45e),
          onPressed: () {
            //getCategories();
          },
        ),
      ]),
    );
  }

  void getCategories() {
    TopCategoryApi.getAllCategories().then((response) {
      print("hayat ");
      if (response.statusCode == 200) {
        print("çalışoyor");
        var gelen = json.decode(utf8.decode(response.bodyBytes));
        var data = gelen['data'];
        for (var i in data) {
          categoryList.add(i['name']);
          print(i["name"]);
        }
      } else {
        print("hata kodu : " + response.statusCode.toString());
      }
    });
  }
}
