// ignore_for_file: camel_case_types, use_key_in_widget_constructors, slash_for_doc_comments, no_logic_in_create_state, prefer_const_constructors_in_immutables, must_call_super, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/Advert-comment.dart';
import 'package:freelancer_market/api/advert_api.dart';
import 'package:freelancer_market/api/freelancer_api.dart';
import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/comments.dart';
import 'package:freelancer_market/models/user.dart';
import 'package:freelancer_market/screens/Components/TopBar.dart';
import 'package:freelancer_market/screens/Components/loading.dart';

class AdvertDetailPage extends StatefulWidget {
  AdvertDetailPage({Key? key, required this.advert}) : super(key: key);

  final Advert advert;

  @override
  State<StatefulWidget> createState() => _advertDetailPageState(advert);
}

class _advertDetailPageState extends State {
  _advertDetailPageState(this.advert);

  final Advert advert;
  /* ilan detay sayfasında ilan , ilan sahibi , user'in diğer ilanları, ilana yapılan yorumlar olacak.
   * 
   * 
   *
   */

  List<Comments> yorumlar = [];
  List<User> yorumYapanlar = [];
  List<Advert> ilanlar = [];
  User owner = User.empyt();
  
  @override
  initState() {
    _veriGetir();
  }

  Future<void> _veriGetir() async {
    int idDeger = 0;
    var commentResp = await AdvertCommentApi.getByAdvertId(advert);
    if (commentResp.statusCode == 200) {
      var gelen = json.decode(utf8.decode(commentResp.bodyBytes));
      var data = gelen["data"];
      for (var i in data) {
        yorumlar.add(Comments.fromJson(i));
        setState(() {});
      }
    }
    var api = FreelancerApi();

    var freelancerResp = await api.getById(advert.freelancer_id);
    if (freelancerResp.statusCode == 200) {
      var cevap = json.decode(utf8.decode(freelancerResp.bodyBytes));
      var veri = cevap["data"];
      owner = User.forFreelancerFromJson(veri);
      idDeger = owner.id!;
      setState(() {});
    }
    var napi = AdvertApi();
    var advertResp = await napi.getByFreelancerId(idDeger);
    if (advertResp.statusCode == 200) {
      var cevap = json.decode(utf8.decode(advertResp.bodyBytes));

      var veri = cevap["data"];
      for (var i in veri) {
        ilanlar.add(Advert.fromJson(i));
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),
              kutu(advert),
              information(advert),
              owner == null ? Center(child: LoadAnim()) : userInfo(owner),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Freelancer'ın diğer ilanları",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              ilanlar.isEmpty
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: LoadAnim(),
                    ))
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 260,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ilanlar.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ilanItem(ilanlar[index]);
                            }),
                      ),
                    ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Yorumlar",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              yorumlar.isEmpty
                  ? Center(child: LoadAnim())
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        height: 500,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: yorumlar.length,
                            itemBuilder: (BuildContext context, int index) {
                              return yorumAlani(yorumlar[index]);
                            }),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Card kutu(Advert ilan) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: Colors.black,
      elevation: 20,
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
                image: NetworkImage(ilan.image_path),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
                child: Text(ilan.title, style: const TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
                child: Text(ilan.price.toString() + " TL",
                    style: TextStyle(fontSize: 18, color: Colors.green[400])),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding information(Advert ilan) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: Colors.black,
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(ilan.info,
                style: const TextStyle(
                  fontSize: 15,
                )),
          ),
        ),
      ),
    );
  }

  Card userInfo(User user) {
    return Card(
      color: const Color(0xffe83c5f),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(29),
      ),
      shadowColor: Colors.black,
      elevation: 20,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 0,
            top: 0,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(30),
                child: Image.network(
                  user.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(user.username,
                      style: const TextStyle(
                          fontSize: 20, color: Color(0xff201a3d))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(user.appellation,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xff201a3d),
                      )),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Padding ilanItem(Advert advert) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black,
        elevation: 20,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width - 60,
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          icon: const Icon(Icons.favorite),
                          iconSize: 32,
                          color: const Color(0xffe83c5f),
                          onPressed: () {}),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(advert.title, style: const TextStyle(fontSize: 18)),
              ),
            ]),
      ),
    );
  }

  Padding yorumAlani(Comments comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 250,
        child: Card(
          color: Colors.amber[50],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Colors.black,
          elevation: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                        Text("Metehan Özalp", style: TextStyle(fontSize: 20)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Card(
                          color: Colors.yellow,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 8, bottom: 8, right: 8),
                            child: Text(
                              comment.date.toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  comment.content,
                  //overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
