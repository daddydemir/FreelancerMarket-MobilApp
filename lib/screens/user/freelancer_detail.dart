

import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/Components/TopBar.dart';

class FreelancerDetailPage extends StatefulWidget{
  const FreelancerDetailPage({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _freelancerDetailPageState();
}

// ignore: camel_case_types
class _freelancerDetailPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfaf4f5f7),
      body:Column(
        children:[
          TopBar(),
          Padding(
            padding:const EdgeInsets.all(10),
            child:SizedBox(
              height:MediaQuery.of(context).size.height-100,
              child: SingleChildScrollView(
                child: Column(
                  children:[
                    resim(context),
                    const Padding(
                      padding: EdgeInsets.all(5)
                    ),
                    info(context),
                    info(context),
                    info(context),
                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }

  Card info(BuildContext context) {
    return Card(
                  color:Colors.white,
                  shadowColor:Colors.black,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child:Column(
                    children:[
                      SizedBox(
                        height:MediaQuery.of(context).size.height/4,
                        child:const Center(
                          child:Text("Tamamlanan Sipariş"),
                        ),
                      ),
                    ],
                  ),
                );
  }

  Card resim(BuildContext context) {
    return Card(
                color:Colors.white,
                shadowColor: Colors.black,
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child:Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height/4,
                      child:Center(
                        child:ClipOval(
                          child:SizedBox.fromSize(
                            size:const Size.fromRadius(70),
                            child:Image.network("https://avatars.githubusercontent.com/u/42716195?v=4"),
                          )
                        ),
                      ),
                    ),
                    const Text("Mehmet Çakmaktaşı",style:TextStyle(fontSize:20),),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Mobil Geliştirici"),
                    ),
                  ],
                ),
              );
  }
}