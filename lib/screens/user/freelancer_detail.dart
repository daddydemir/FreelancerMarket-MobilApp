// ignore_for_file: empty_constructor_bodies, must_call_super, unnecessary_null_comparison, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancer_market/models/freelancer.dart';
import 'package:freelancer_market/screens/Components/TopBar.dart';

import '../../models/advert.dart';
import '../../service/advert/advertService.dart';
import '../../service/user/favoriteService.dart';
import '../skeleton.dart';

class FreelancerDetailPage extends StatefulWidget {
  const FreelancerDetailPage({Key? key, required this.user}) : super(key: key);
  final Freelancer user;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _freelancerDetailPageState(user);
}

// ignore: camel_case_types
class _freelancerDetailPageState extends State {
  _freelancerDetailPageState(this.user);
  final Freelancer user;

  var service = AdvertService();
  var favoriService = FavoriteService();
  var favoriIlanlar = <Advert>[];
  var ilanlar = <Advert>[];
  Map favMap = {};

  favorileriGetir() async {
    favoriIlanlar = await favoriService.getAll();
    for (int i = 0; i < ilanlar.length; i++) {
      favMap[ilanlar[i].id.toString()] = "0xffffffff";
      for (int k = 0; k < favoriIlanlar.length; k++) {
        if (favoriIlanlar[k].id == ilanlar[i].id) {
          favMap[ilanlar[i].id.toString()] = "0xffe83c5f";
        }
      }
    }
    setState(() {});
  }

  ilanGetir() async {
    ilanlar = await service.getAdvertByUserId(user.id);
    sleep(Duration(seconds: 1));
    setState(() {});
  }

  @override
  initState() {
    ilanGetir();
    favorileriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfaf4f5f7),
      body: Column(children: [
        TopBar(),
        user == null
            ? const Center(child: Text("Loading"))
            : Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        resim(user),
                        const Padding(padding: EdgeInsets.all(5)),
                        score(),
                        adverts(),
                        info(user),
                        info(user),
                        info(user),
                      ],
                    ),
                  ),
                ),
              ),
      ]),
    );
  }

  Widget shimmer() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3 - 20,
      width: MediaQuery.of(context).size.width - 20,
      child: Column(
        children: const [
          Expanded(
            flex: 3,
            child: Skeleton(height: 100),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 1,
            child: Skeleton(),
          ),
        ],
      ),
    );
  }

  Widget adverts() {
    return ilanlar.isEmpty
        ? shimmer()
        : SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ilanlar.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.white,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(ilanlar[index].image_path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: const Icon(Icons.favorite),
                                    iconSize: 32,
                                    color: Color(int.parse(
                                        favMap[ilanlar[index].id.toString()])),
                                    onPressed: () async {
                                      if (favMap[
                                              ilanlar[index].id.toString()] !=
                                          "0xffe83c5f") {
                                        var status = await favoriService
                                            .add(ilanlar[index].id);
                                        if (status == true) {
                                          favMap[ilanlar[index].id.toString()] =
                                              "0xffe83c5f";
                                        }
                                      } else {
                                        var status = await favoriService
                                            .delete(ilanlar[index].id);
                                        if (status == true) {
                                          favMap[ilanlar[index].id.toString()] =
                                              "0xffffffff";
                                        }
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(ilanlar[index].title, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize:16),),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
  }

  Widget score() {
    return SizedBox(
      height: 64,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black,
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              user.average.toString(),
              style: const TextStyle(fontSize: 23),
            ),
            const Icon(
              Icons.star,
              size: 30,
              color: Colors.amber,
            ),
          ]),
        ),
      ),
    );
  }

  Card info(Freelancer user) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.about),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card resim(Freelancer user) {
    return Card(
      color: const Color(0xffe83c5f),
      shadowColor: Colors.black,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Center(
              child: ClipOval(
                  child: SizedBox.fromSize(
                size: const Size.fromRadius(70),
                child: Image.network(user.imagePath, fit: BoxFit.cover),
              )),
            ),
          ),
          Text(
            user.name + " " + user.surname,
            style: const TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user.appellation),
          ),
        ],
      ),
    );
  }
}
