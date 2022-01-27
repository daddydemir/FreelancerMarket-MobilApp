import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Components/TopBar.dart';

class WalletPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _walletPageState();
  }
}

class _walletPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f5f7),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 40),
        child: Center(
            child: Column(
          children: [
            TopBar(),
            const Padding(
              padding: EdgeInsets.all(10),
              child:Text("Cüzdanım",style:TextStyle(fontSize:25,fontWeight:FontWeight.bold)),
            ),
            PhysicalModel(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              elevation: 20,
              shadowColor: Colors.black,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 190,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text(
                          "100,00 TL",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Güncel Bakiye",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: const Color(0xffffffff),
                    shadowColor: Colors.black,
                    elevation: 20,
                    child: InkWell(
                      splashColor: Colors.blue,
                      onTap: () {
                        print("Kutuya Tıkladın");
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Cüzdan Hareketlerim",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: const Color(0xffffffff),
                    shadowColor: Colors.black,
                    elevation: 20,
                    child: InkWell(
                      splashColor: Colors.red,
                      onTap: () {
                        print("Kutuya Tıkladın");
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Ödemelerim",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(10)),
            PhysicalModel(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              elevation: 20,
              shadowColor: Colors.black,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 190,
                child: const Center(child: Text("daddydemir")),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
