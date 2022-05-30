// ignore_for_file: camel_case_types, use_key_in_widget_constructors, slash_for_doc_comments, no_logic_in_create_state, prefer_const_constructors_in_immutables, must_call_super, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/comments.dart';
import 'package:freelancer_market/screens/Components/TopBar.dart';
import 'package:freelancer_market/screens/Components/loading.dart';

import '../../models/_User.dart';
import '../../models/freelancer.dart';
import '../../models/user.dart';
import '../../service/advert/advertService.dart';
import '../../service/commentService.dart';
import '../../service/user/freelancerService.dart';

class AdvertDetailPage extends StatefulWidget {
  AdvertDetailPage({Key? key, required this.advert}) : super(key: key);

  final Advert advert;

  @override
  State<StatefulWidget> createState() => _advertDetailPageState(advert);
}

class _advertDetailPageState extends State {
  _advertDetailPageState(this.advert);

  final Advert advert;

  var as = AdvertService();
  var cs = CommentService();
  var fs = FreelancerService();
  
  List<Comments> yorumlar = [];
  List<User> yorumYapanlar = [];
  List<Advert> ilanlar = [];
  List temp = [];
  Freelancer owner = Freelancer.empty();
  
  @override
  initState() {
    _veriGetir();
  }

  ilanGetir() async {
    ilanlar = await as.getAdvertByUserId(owner.id);
    setState((){});
  }

  ownerGetir() async {
    owner = await fs.getUser(advert.freelancer_id);
    setState(() {});
  }

  yorumGetir() async {
    temp = await cs.getByAdvertId(advert);
    yorumlar = temp[0];
    yorumYapanlar = temp[1];
    setState((){});
  }

  void _veriGetir() async {
    await ownerGetir();
    await ilanGetir();
    await yorumGetir();
  }

  @override
  Widget build(BuildContext context) {
    return ilanlar.isEmpty ? Center(child:LoadAnim()) :Scaffold(
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

  Card userInfo(Freelancer user) {
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
                  user.imagePath,
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
    User yorumyapan = User.empyt();
    for(int i = 0; i<yorumYapanlar.length; i++){
      if(comment.userId == yorumYapanlar[i].id){
        yorumyapan = yorumYapanlar[i];
      }
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SizedBox(
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Colors.black,
          elevation: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                  flex:1,
                  child: Padding(
                    padding: const EdgeInsets.only(top:8,left:8,right:8),
                    child:ClipOval(
                      child:SizedBox.fromSize(
                        size:const Size.fromRadius(30),
                        child:Image.network(
                          yorumyapan.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                        //Text(yorumyapan.username,style: const TextStyle(fontSize: 20)),
                  ),
                ),
                Expanded(
                  flex:2,
                  child: Padding(
                    padding: const EdgeInsets.only(top:8,left:8,right:8),
                    child:Text(yorumyapan.username , style:const TextStyle(fontSize:18, fontWeight: FontWeight.bold),),
                  ),
                ),
                Expanded(
                  flex:2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Card(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 8, bottom: 8, right: 8),
                            child: Text(
                              comment.date.toString(),
                              style: const TextStyle(color: Colors.white)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(left:15,top:15,bottom:10,right:10),
                child: Text(
                  comment.content,
                  style: const TextStyle(fontSize:15)
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
