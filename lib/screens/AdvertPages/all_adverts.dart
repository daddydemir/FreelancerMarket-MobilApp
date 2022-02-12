import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/advert_api.dart';
import 'package:freelancer_market/api/freelancer_api.dart';
import 'package:freelancer_market/api/sub_category_api.dart';
import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/freelancer.dart';
import 'package:freelancer_market/models/sub_category.dart';

class AllAdverts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _allAdvertsState();
}

class _allAdvertsState extends State {
  final List<Advert> ilanlar = [];
  List<Advert> customIlan = [];
  List<Freelancer> userlar = [];
  List<SubCategory> kategoriler = [];
  Color fav = Colors.white;

  Future<void> _veriGetir() async {
    var response = await AdvertApi.getAllAdverts();
    if (response.statusCode == 200) {
      var gelen = json.decode(utf8.decode(response.bodyBytes));
      var data = gelen["data"];
      for (var i in data) {
        ilanlar.add(Advert(
            i["id"],
            i["freelancerId"],
            i["subCategoryId"],
            i["title"],
            i["price"],
            i["info"],
            i["imagePath"],
            DateTime.parse(i["date"])));
        var calisanDetay =
            await FreelancerApi.getFreelancerById(i["freelancerId"]);
        if (calisanDetay.statusCode == 200) {
          var resp = json.decode(utf8.decode(calisanDetay.bodyBytes));
          var veri = resp["data"];
          userlar.add(Freelancer.forAdvert(veri["id"], veri["userName"],
              veri["appellation"], veri["imagePath"]));
        }
        setState(() {});
      }
    }
    var resp = await SubCategoryApi.getAllCategories();
    if (resp.statusCode == 200) {
      var gelen = json.decode(utf8.decode(resp.bodyBytes));
      var data = gelen["data"];
      for (var i in data) {
        kategoriler.add(SubCategory(
            i["id"], i["topCategoryId"], i["name"], i["imagePath"] = "none"));
        customIlan = ilanlar;
        setState(() {});
      }
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
      body: Center(
        child: Column(
          children: [
            const Text("Demir"),
            SizedBox(
              height: 50,
              child: kategoriler.isEmpty
                  ? const Center(child: Text("Wait Fuck"))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: kategoriler.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              print(ilanlar[0].sub_category_id.toString()+". kategori");
                              customIlan = [];
                              setState(() {
                                for (int i = 0; i < ilanlar.length; i++) {
                                  if (kategoriler[index].id ==
                                      ilanlar[i].sub_category_id) {
                                        print(kategoriler[index].name);
                                    customIlan.add(ilanlar[i]);
                                  }
                                }
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(kategoriler[index].name,
                                  style: const TextStyle(fontSize: 18)),
                            ),
                          ),
                        );
                      }),
            ),
            customIlan.isEmpty
                ? const Text("Loading . . .")
                : Flexible(
                    child: ListView.builder(
                        itemCount: customIlan.length,
                        itemBuilder: (BuildContext context, int index) {
                          return kutu(customIlan[index], userlar[index]);
                        }),
                  ),
          ],
        ),
      ),
    );
  }

  Card kutu(var ilan, var user) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.black,
      elevation: 20,
      child: Column(
        children: [
          Stack(children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(ilan.image_path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: InkWell(
                  onTap: () {},
                  child: Card(
                    color: const Color(0xffe83c5f),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.black,
                    elevation: 20,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 0,
                          top: 0,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(30),
                                      child: Image.network(
                                        user.imagePath,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(user.username,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xff201a3d))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(user.appellation,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Color(0xff201a3d),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: const Icon(Icons.favorite),
                    iconSize: 32,
                    color: fav,
                    onPressed: () {
                      setState(() {
                        if (fav != const Color(0xffe83c5f)) {
                          fav = const Color(0xffe83c5f);
                        } else {
                          fav = Colors.white;
                        }
                      });
                    }),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(ilan.info),
                ),
                Expanded(
                  flex: 1,
                  child: Text(ilan.price.toString() + " TL",
                      style:
                          const TextStyle(color: Colors.green, fontSize: 18)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
