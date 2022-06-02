// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/top_category_api.dart';
import 'package:freelancer_market/screens/Components/loading.dart';
import 'package:freelancer_market/screens/home/sub_category.dart';

import '../service/category/topCategoryService.dart';
import 'Components/SearchBar.dart';
import 'Components/TopBar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _mainPageState();
  }
}

// ignore: camel_case_types
class _mainPageState extends State {
  var service = TopCategoryService();
  var api = TopCategoryApi();
  var categories = [];
  var categoryList = [];
  var idList = [];
  var colorL = [
    0xffffbf00,
    0xff67c1d6,
    0xffff5159,
    0xff4b4f52,
    0xff3faa40,
    0xff4260e9
  ];
  int li = 0;
  @override
  void initState() {
    //getCategories();
    _veriGetir();
    super.initState();
  }

  Future<void> _veriGetir() async {
    categories = await service.getAll();
    li = categories.length;
    for(var i in categories) {
      idList.add(i.id);
    }
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    var st = false;
    return Scaffold(
    //  bottomNavigationBar: MyBottomBar(),
      backgroundColor: const Color(0xfff4f5f7),
      body: Column(children: [
        TopBar(),
        //topMenu(),
        SearchBar(),
        Expanded(
          child: SizedBox(
            child: categories.isEmpty
                ? Center(
                  child:LoadAnim(),
                )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: li,
                    itemBuilder: (context, index) {
                      if(st){
                        st = false;
                        return const Text("");
                      }
                      if (li - 1 == index) {
                        return tekSatir(colorL[index], categories[index], idList[index]);
                      } else if(st == false) {
                        st = true;
                        return satir(colorL[index], categories[index], idList[index], colorL[index+1],categories[index+1], idList[index+1]);
                      }else{
                        return const Text("Hata");
                      }
                    }),
          ),
        ),
      ]),
    );
  }
  Row satir(var c, var a , var index1, var c2 , var a2, var index2) {
    return Row(
      children: [
        kutu(c, a , index1),
        kutu(c2, a2, index2),
        // ff5159
      ],
    );
  }

  Row tekSatir(var c, var a , var index) {
    return Row(
      children: [
        kutu(c, a, index),
      ],
    );
  }

  Expanded kutu(var a, var x , var index) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 7, top: 7, right: 7),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Color(a),
        shadowColor: Colors.black,
        elevation: 20,
        child: InkWell(
          splashColor: Colors.blue,
          onTap: () {
            print("id'si : " + index.toString());
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubCategoryPage(index: index),
                ),
              );
          },
          child: SizedBox(
            height: 200,
            child: Center(
              child: Text(
                x.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Padding topMenu() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        top: 20,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.network(
          "https://raw.githubusercontent.com/daddydemir/images/main/freelancer-market/PNG-4x/acik-zemin%404x.png",
          width: 200,
        ),
        IconButton(
          iconSize: 35,
          icon: const Icon(Icons.add_alert),
          tooltip: "Alert Message",
          color: const Color(0xfffac45e),
          onPressed: () {
            //getCategories();
          },
        ),
      ]),
    );
  }
}
