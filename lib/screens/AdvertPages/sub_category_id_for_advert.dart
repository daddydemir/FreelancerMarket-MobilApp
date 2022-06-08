// ignore_for_file: unrelated_type_equality_checks, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/freelancer.dart';
import 'package:freelancer_market/screens/AdvertPages/advert_detail.dart';
import 'package:freelancer_market/screens/Components/loading.dart';

import '../../service/advert/advertService.dart';
import '../../service/user/favoriteService.dart';
import '../../service/user/freelancerService.dart';
import '../Components/TopBar.dart';
import '../user/freelancer_detail.dart';

class SubCategoryIdForAdvertPage extends StatefulWidget {
  SubCategoryIdForAdvertPage({Key? key, required this.index, required this.ilanIsmi}): super(key: key);

  final int index;
  var ilanIsmi= "";

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _subCategoryIdForAdvertPageState(index,ilanIsmi);
}

// ignore: camel_case_types
class _subCategoryIdForAdvertPageState extends State {
  _subCategoryIdForAdvertPageState(this.index, this.ilanismi);

  final int index;
  var ilanismi = "";

  var advertService = AdvertService();
  var freelancerService = FreelancerService();
  var favoriService = FavoriteService();
  var adverts = <Advert>[];
  var freelancers = <Freelancer>[];
  var favoridekiler = <Advert>[];
  Map favMap = {};
  

  Color fav = Colors.white; //Color(0xffe83c5f);

  Future<void> _veriGetir() async {
    adverts = await advertService.getBySubCategoryId(index);
    freelancers = await freelancerService.getAllFreelancers();
    favoridekiler = await favoriService.getAll();
    for(var i=0;i<adverts.length; i++){
      favMap[adverts[i].id.toString()] = "0xffffffff";
      for(var k=0;k<favoridekiler.length;k++){
      if(favoridekiler[k].id == adverts[i].id){
        favMap[adverts[i].id.toString()] = "0xffe83c5f";
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
      body: freelancers.isEmpty
          ? Center(child: LoadAnim())
          : Column(
            children: [
              TopBar(),
              Text(ilanismi,style:const TextStyle(fontSize:20)),
              Expanded(
                child: ListView.builder(
                    itemCount: adverts.length,
                    itemBuilder: (BuildContext context, int index) {
                      for(int i = 0;i<adverts.length; i++){
                        for(int k = 0;k<freelancers.length; k++){
                          if(adverts[i].freelancer_id == freelancers[k].id){
                            //return 
                          }
                        }
                      }
                      return InkWell(
                        onTap: () {
                          print("Detay : " + adverts[index].id.toString());
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>AdvertDetailPage(advert: adverts[index]),),);
                          // bu kısımda detay sayfasına gidecek . . .
                        },
                        child: item(freelancers[index], adverts[index]),
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
    for(int i=0;i<freelancers.length; i++){
      if(advert.freelancer_id == freelancers[i].id){
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
