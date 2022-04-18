// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../models/advert.dart';
import '../../service/advert/advertService.dart';
import '../AdvertPages/add_advert.dart';
import '../AdvertPages/advert_edit.dart';
import '../Components/TopBar.dart';
import '../Components/loading.dart';

class MyAdverts extends StatefulWidget {
  MyAdverts({Key? key, required this.UserId}) : super(key: key);
  var UserId;
  @override
  State<StatefulWidget> createState() => _myOrders(UserId);
}

class _myOrders extends State {
  _myOrders(this.index);
  var index;
  List<Advert> adverts = [];
  var service = AdvertService();

  Future<void> _veriGetir() async {
    adverts = await service.getAdvertByUserId(index);
    setState(() {});
  }

  @override
  void initState() {
    _veriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(),
          AddNewOrder(),
          Grid(),
        ],
      ),
    );
  }

  Widget Grid() {
    return Expanded(
      child: adverts.isEmpty
          ? Center(child: LoadAnim())
          : Padding(
              padding:
                  const EdgeInsets.only(top: 2, left: 8, right: 8, bottom: 8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: adverts.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewItem(adverts[index]);
                },
              ),
            ),
    );
  }

  Widget NewItem(Advert advert) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 20,
      shadowColor: Colors.black,
      child: InkWell(
        onTap:(){
          Navigator.push(context,MaterialPageRoute(builder: (context) => AdvertEdit(advert: advert),),);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                ),
                image: DecorationImage(
                  image: NetworkImage(advert.image_path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(advert.title ,textAlign: TextAlign.center ,overflow: TextOverflow.ellipsis, style:const TextStyle(fontSize:16,)),
            ),),
            Center(child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(advert.price.toString()+" TL" , style: const TextStyle(fontSize:20 , color:Colors.green)),
            ),)
          ],
        ),
      ),
    );
  }

  Widget AddNewOrder() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
      child: SizedBox(
        height: 60,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: const Color(0xffffbf00),
          shadowColor: Colors.black,
          elevation: 20,
          child: InkWell(
            onTap: () {
               Navigator.push(context,MaterialPageRoute(builder: (context) => AddAdvert(),),);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.add, size: 35, color: Colors.black),
                Text("Yeni İlan Ekle", style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
