import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/advert_api.dart';
import 'package:freelancer_market/api/freelancer_api.dart';
import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/freelancer.dart';
import 'package:freelancer_market/screens/AdvertPages/advert_detail.dart';

class SubCategoryIdForAdvertPage extends StatefulWidget {
  const SubCategoryIdForAdvertPage({Key? key, required this.index})
      : super(key: key);

  final int index;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() =>
      // ignore: no_logic_in_create_state
      _subCategoryIdForAdvertPageState(index);
}

// ignore: camel_case_types
class _subCategoryIdForAdvertPageState extends State {
  _subCategoryIdForAdvertPageState(this.index);

  final int index;
  
  List<Advert> ilanlar = [];
  List<Freelancer> calisanlar = [];
  Color fav = Colors.white; //Color(0xffe83c5f);

  Future<void> _veriGetir() async {
    var gelen = await AdvertApi.getBySubCategoryId(index);
    if (gelen.statusCode == 200) {
      var cevap = json.decode(utf8.decode(gelen.bodyBytes));
      var data = cevap["data"];
      for (var i in data) {
        ilanlar.add(Advert.fromJson(i));

        var calisanDetay = await FreelancerApi.getById(i["freelancerId"]);
        if (calisanDetay.statusCode == 200) {
          var resp = json.decode(utf8.decode(calisanDetay.bodyBytes));
          var veri = resp["data"];
          calisanlar.add(Freelancer.forAdvert(veri));
        }
      }
    } setState(() {});
  }

  @override
  void initState() {
    _veriGetir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: calisanlar.isEmpty
          ? const Center(child: Text("loading"))
          : ListView.builder(
              itemCount: ilanlar.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print("Detay : " + ilanlar[index].id.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AdvertDetailPage(advert: ilanlar[index]),
                      ),
                    );
                    // bu kısımda detay sayfasına gidecek . . .
                  },
                  child: item(calisanlar[index], ilanlar[index]),
                );
              },
            ),
    );
  }

  Card kart(Freelancer user) {
    return Card(
      color: const Color(0xffe83c5f),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      shadowColor: Colors.black,
      elevation: 20,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: satir(user),
      ),
    );
  }

  Card item(Freelancer user, Advert advert) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.black,
      elevation: 20,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(advert.image_path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  top: 5,
                ),
                child: InkWell(
                    onTap: () {
                      print("user detail page");
                    },
                    child: kart(user)),
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
            ],
          ),
          altBar(advert),
        ],
      ),
    );
  }

  Padding altBar(Advert advert) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(advert.info),
          ),
          Expanded(
            flex: 1,
            child: Text(advert.price.toString() + " TL",
                style: const TextStyle(color: Colors.green, fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Padding satir(Freelancer user) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 0,
        top: 0,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(30),
                child: Image.network(
                  user.imagePath,
                  fit: BoxFit.cover,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(user.username,
                      style: const TextStyle(
                          fontSize: 20, color: Color(0xff201a3d))),
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
        //fiyat(),
      ]),
    );
  }
}
