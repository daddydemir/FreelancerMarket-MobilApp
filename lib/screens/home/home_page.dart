import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/advert_api.dart';
import 'package:freelancer_market/api/freelancer_api.dart';
import 'package:freelancer_market/api/sub_category_api.dart';
import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/freelancer.dart';
import 'package:freelancer_market/models/sql_user.dart';
import 'package:freelancer_market/models/sub_category.dart';
import 'package:freelancer_market/screens/AdvertPages/advert_detail.dart';
import 'package:freelancer_market/screens/AdvertPages/sub_category_id_for_advert.dart';
import 'package:freelancer_market/screens/Components/SearchBar.dart';
import 'package:freelancer_market/screens/Components/TopBar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freelancer_market/screens/user/freelancer_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _homePageState();
  }
}

// ignore: camel_case_types
class _homePageState extends State with TickerProviderStateMixin {
  var users = [];
  var adverts = [];
  var categories = [];

  @override
  // ignore: must_call_super
  initState() {
    _veriGetir();
  }

  Future<void> _veriGetir() async {
    var resp = await FreelancerApi.getMostPopularFreelancers();
    if (resp.statusCode == 200) {
      var gelen = json.decode(utf8.decode(resp.bodyBytes));
      var data = gelen["data"];
      for (var i in data) {
        users.add(Freelancer.fromJson(i));
        setState(() {});
      }
    }
    var advertResp = await AdvertApi.getMostPopularAdverts();
    if (advertResp.statusCode == 200) {
      var advertGelen = json.decode(utf8.decode(advertResp.bodyBytes));
      var veri = advertGelen["data"];
      for (var i in veri) {
        adverts.add(Advert.fromJson(i));
        setState(() {});
      }
    }
    var categoryResp = await SubCategoryApi.getMostPopularSubCategories();
    if(categoryResp.statusCode == 200) {
      var categoryGelen = json.decode(utf8.decode(categoryResp.bodyBytes));
      var info = categoryGelen["data"];
      for(var i in info){
        categories.add(SubCategory.fromJson(i));
        setState(() {});
      }
    }
    else{
      print("Durum : " + categoryResp.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff4f5f7),
      body: Column(
        children: [
          TopBar(),
          SearchBar(),
          users.isEmpty && adverts.isEmpty && categories.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 200,
                  ),
                  child: SpinKitFadingCube(
                    color: const Color(0xffe83c5f),
                    size: 50,
                    controller: AnimationController(
                        duration: const Duration(milliseconds: 1200),
                        vsync: this),
                  ),
                )
              : Expanded(
                  child: ListView(
                    children: [
                      const Text(
                        "En sevilen FREELANCER'lar",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3.3,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              return userComponent(users[index]);
                            }),
                      ),
                      const Text(
                        "İlgi çekici İLAN'lar",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3.3,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: adverts.length,
                            itemBuilder: (context, index) {
                              return advertComponent(adverts[index]); //component();
                            }),
                      ),
                      const Text(
                        "En sevilen KATEGORİ'ler",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3.3,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return categoryComponent(categories[index]); //component();
                            }),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget userComponent(Freelancer user) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        elevation: 10,
        shadowColor: Colors.black,
        child: InkWell(
          splashColor: const Color(0xffe83c5f),
          onTap: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FreelancerDetailPage(user: user),
                      ),
                    );
          },
          child: SizedBox(
            width: 180,
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(55),
                      child: Image.network(
                        user.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(user.username, style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget advertComponent(Advert advert) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        elevation: 10,
        shadowColor: Colors.black,
        child: InkWell(
          splashColor: const Color(0xffe83c5f),
          onTap: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdvertDetailPage(advert: advert),
                      ),
                    );
          },
          child: SizedBox(
            width: 180,
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(55),
                      child: Image.network(
                        advert.image_path,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(advert.title, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryComponent(SubCategory category) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        elevation: 10,
        shadowColor: Colors.black,
        child: InkWell(
          splashColor: const Color(0xffe83c5f),
          onTap: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubCategoryIdForAdvertPage(index: category.id),
                      ),
                    );
          },
          child: SizedBox(
            width: 180,
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(55),
                      child: Image.network(
                        category.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(category.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 17)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
