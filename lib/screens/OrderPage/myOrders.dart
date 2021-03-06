// ignore_for_file: no_logic_in_create_state, use_key_in_widget_constructors, camel_case_types, prefer_const_constructors, must_call_super, file_names

import 'package:flutter/material.dart';

import '../../models/_User.dart';
import '../../models/advert.dart';
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
  List<Users> users = [];
  List<Advert> adverts = [];
  var os = OrderService();

  _veriGetir() async {
    var liste = await os.getOrderFreelancerId();
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
      body: adverts.isEmpty ? Center(child:LoadAnim()) 
      : Column(
        children: [
          TopBar(),
          SearchBar(),
          liste(),
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
                      IconButton(
                        icon: const Icon(Icons.verified_user),
                        color: orders[index].status ? Colors.green : Colors.red,
                        iconSize:40,
                        onPressed: () async {
                          if(orders[index].status == false){
                            // sipari?? onaylama
                            var deger = await os.SiparisOnay(orders[index]);
                            if(deger){
                              // sipari?? ok
                              orders[index].status = true;
                            }else{
                              print("Elbet bir sebebi vard??r.");
                            }
                          }
                        }
                      ),
                      Text(users[index].username),
                     
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(adverts[index].price.toString()+ " TL", overflow: TextOverflow.ellipsis,),
                      )
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
