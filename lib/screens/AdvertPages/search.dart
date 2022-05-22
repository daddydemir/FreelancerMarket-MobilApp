// ignore_for_file: use_key_in_widget_constructors, camel_case_types, prefer_const_constructors, must_be_immutable, no_logic_in_create_state, avoid_print

import 'package:flutter/material.dart';
import '../../models/advert.dart';
import '../../models/freelancer.dart';
import '../../service/user/favoriteService.dart';
import '../../service/user/freelancerService.dart';
import '../Components/TopBar.dart';
import '../Components/loading.dart';
import 'advert_detail.dart';

class Search extends StatefulWidget{
  Search({Key? key  , required this.liste}): super(key:key);
  var liste = <Advert>[];
  @override
  State<StatefulWidget> createState() => _search(liste);

}

class _search extends State{
  _search(this.liste);
  
  var freelancerService = FreelancerService();
  var favoriService = FavoriteService();
  var liste = <Advert>[];
  var freelancers = <Freelancer>[];
  var favoridekiler = <Advert>[];
  Map favMap = {};

  Future<void> _veriGetir() async {
    freelancers = await freelancerService.getAllFreelancers();
    favoridekiler = await favoriService.getAll();
    for(var i=0;i<liste.length; i++){
      favMap[liste[i].id.toString()] = "0xffffffff";
      for(var k=0;k<favoridekiler.length;k++){
      if(favoridekiler[k].id == liste[i].id){
        favMap[liste[i].id.toString()] = "0xffe83c5f";
      }    
    }
    }
    setState(() {});
  }

  @override
  void initState() {
    _veriGetir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:freelancers.isEmpty
          ? Center(child: LoadAnim())
          : Column(
        children:[
          TopBar(),
          Expanded(
            child:ListView.builder(
                    itemCount: liste.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          print("Detay : " + liste[index].id.toString());
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>AdvertDetailPage(advert: liste[index]),),);
                          // bu kısımda detay sayfasına gidecek . . .
                        },
                        child: item(freelancers[index], liste[index]),
                      );
                    },
                  ),
          ),
        ],
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
                      color: Color(int.parse(favMap[advert.id.toString()])),
                      onPressed: () async{

                        if (favMap[advert.id.toString()] != "0xffe83c5f") {
                            var status =  await favoriService.add(advert.id);
                            if(status == true){
                              favMap[advert.id.toString()] = "0xffe83c5f";
                            }
                          } else {
                            var status = await favoriService.delete(advert.id);
                            if(status == true){
                            favMap[advert.id.toString()] = "0xffffffff";
                            }
                          }
                        setState(() {});
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
            child: Text(advert.title),
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