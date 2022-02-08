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
          calisanlar.add(Freelancer.forAdvert(
              veri["id"], veri["userName"], veri["imagePath"]));
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
      color: const Color(0xffe83c5f),
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
                height: 200,
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
                padding: const EdgeInsets.only(left: 10,top: 10,),
                child: Row(children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(30),
                      child: Image.network(
                        calisanlar[0].imagePath,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(calisanlar[0].username, style: const TextStyle(fontSize:30,color:Color(0xff201a3d),backgroundColor:Color(0xffe83c5f),)),
                  ),
                ]),
              ),
            ],
          ),
          Text(ilanlar[0].price.toString() + "₺", style: GoogleFonts.lato()),
        ],
      ),
    );
  }
}
