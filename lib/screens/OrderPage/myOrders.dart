// ignore_for_file: no_logic_in_create_state, use_key_in_widget_constructors, camel_case_types, prefer_const_constructors, must_call_super

import 'package:flutter/material.dart';

import '../../models/_User.dart';
import '../../models/advert.dart';
import '../../models/freelancer.dart';
import '../../models/order.dart';
import '../../service/orderService.dart';
import '../Components/SearchBar.dart';
import '../Components/TopBar.dart';
import '../Components/loading.dart';

class MyOrders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _myOrders();
}

class _myOrders extends State {
  List<Order> orders = [];
  List<Freelancer> users = [];
  List<Advert> adverts = [];
  var os = OrderService();

  _veriGetir() async {
    var liste = await os.orderGet();
    orders = liste[0];
    users = liste[1];
    adverts = liste[2];
    setState(() {});
  }

  @override
  void initState() {
    _veriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f5f7),
      body: Column(
        children: [
          TopBar(),
          SearchBar(),
          adverts.isEmpty ? LoadAnim() : liste(),
        ],
      ),
    );
  }

  Widget liste() {
    return SizedBox(
      height:MediaQuery.of(context).size.height / 1.3,
      child:ListView.builder(
        itemCount: adverts.length,
        //shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          return Card(
            color:Colors.white,
            elevation:20,
            shadowColor: Colors.black,
            shape:RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(10)
            ),
            child:Row(
              children:[
                Expanded(
                  child:ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)
                    ),
                    child: Image.network(
                      adverts[index].image_path,
                      fit:BoxFit.cover,
                    ),
                  )
                ),
                Expanded(
                  child:Column(
                    children:[
                      ClipOval(
                        child:SizedBox.fromSize(
                          size: const Size.fromRadius(30),
                          child:Image.network(
                            users[index].imagePath,
                            fit:BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(adverts[index].title)
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
