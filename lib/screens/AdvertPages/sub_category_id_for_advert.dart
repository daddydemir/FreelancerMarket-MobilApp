import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/advert_api.dart';
import 'package:freelancer_market/api/freelancer_api.dart';
import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/freelancer.dart';
import 'package:google_fonts/google_fonts.dart';

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
  Color fav = Colors.white;//Color(0xffe83c5f);

  Future<void> _veriGetir() async {
    var gelen = await AdvertApi.getBySubCategoryId(index);
    if (gelen.statusCode == 200) {
      var cevap = json.decode(utf8.decode(gelen.bodyBytes));
      var data = cevap["data"];
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
          calisanlar.add(Freelancer.forAdvert(veri["id"], veri["userName"],
              veri["appellation"], veri["imagePath"]));
        }
        setState(() {});
      }
    } else {
      print("veri çekme başarısız");
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
      body: ilanlar.isEmpty
          ? const Center(child: Text("loading"))
          : Column(
              children: [const Padding(padding: EdgeInsets.all(15)), item()]),
    );
  }

  Card item() {
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
                    image: NetworkImage(ilanlar[0].image_path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                ),
                child: Row(children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(30),
                      child: Image.network(
                        calisanlar[0].imagePath,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(calisanlar[0].username,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Color(0xff201a3d),
                              backgroundColor: Color(0xffe83c5f),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(calisanlar[0].appellation,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff201a3d),
                              backgroundColor: Color(0xffe83c5f),
                            )),
                      ),
                    ],
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child:IconButton(
                      icon:const Icon(Icons.favorite),
                      iconSize:32,
                      color:fav,
                      onPressed: () {
                        setState((){
                          if(fav != const Color(0xffe83c5f)){
                            fav =  const Color(0xffe83c5f);
                          }else{
                            fav = Colors.white;
                          }
                          
                        });
                      }
                    ),),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 1,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Expanded(
                flex:1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(30),
                      child: Image.network(
                        calisanlar[0].imagePath,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex:3,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(calisanlar[0].username,
                            style: const TextStyle(
                                fontSize: 30, color: Color(0xff201a3d))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(calisanlar[0].appellation,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff201a3d),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex:3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(ilanlar[0].price.toString() + " TL",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight:FontWeight.bold,
                          color: Colors.green,
                        )),
                  ),
                ),
              ),
            ]),
          ),
          //Text(ilanlar[0].price.toString() + " TL", style: const TextStyle(fontSize:30,color:Color(0xff201a3d),)),
        ],
      ),
    );
  }
}
