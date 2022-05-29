// ignore_for_file: camel_case_types, use_key_in_widget_constructors, no_logic_in_create_state, prefer_const_constructors, must_call_super, unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/AdvertPages/advert_detail.dart';

import '../../models/_User.dart';
import '../../models/advert.dart';
import '../../models/freelancer.dart';
import '../../service/user/favoriteService.dart';
import '../../service/user/freelancerService.dart';
import '../Components/TopBar.dart';
import '../Components/loading.dart';
import '../user/freelancer_detail.dart';

class FavoriAdverts extends StatefulWidget{
  const FavoriAdverts({Key? key, required this.user}): super(key: key);
  final Users user;
  @override
  State<StatefulWidget> createState() => _favoriAdverts(user);
}

class _favoriAdverts extends State{
  _favoriAdverts(this.user);

  final Users user;
  
  var serviceFavori = FavoriteService();
  var serviceFreelancer = FreelancerService();


  var favoridekiler = <Advert>[];
  var freelancers = <Freelancer>[];

  Map favMap = {};

  @override
  initState() {
    _veriGetir();
  }

  Future<void> _veriGetir() async {
    freelancers = await serviceFreelancer.getAllFreelancers();
    favoridekiler = await serviceFavori.getAll();
    for (var i = 0; i <favoridekiler.length; i++){
      favMap[favoridekiler[i].id.toString()] = "0xffe83c5f";
    }
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favoridekiler.isEmpty
      ? Center(child:LoadAnim())
      : Column(
        children: [
          TopBar(),
          Expanded(
                child: ListView.builder(
                    itemCount: favoridekiler.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>AdvertDetailPage(advert: favoridekiler[index]),),);
                          // bu kısımda detay sayfasına gidecek . . .
                        },
                        child: item(freelancers[index], favoridekiler[index]),
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
    for(int i=0;i<freelancers.length;i++) {
      if(advert.freelancer_id == freelancers[i].id) {
        user = freelancers[i];
      }
    }
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
                       Navigator.push(context,MaterialPageRoute(builder: (context) => FreelancerDetailPage(user: user),),);
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
                            var status =  await serviceFavori.add(advert.id);
                            if(status == true){
                              favMap[advert.id.toString()] = "0xffe83c5f";
                            }
                          } else {
                            var status = await serviceFavori.delete(advert.id);
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


}