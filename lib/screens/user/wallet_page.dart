// ignore_for_file: camel_case_types, no_logic_in_create_state, unused_import, prefer_typing_uninitialized_variables, must_call_super, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/models/wallet_trans.dart';
import 'package:freelancer_market/screens/Components/loading.dart';

import '../../models/_User.dart';
import '../../service/user/walletService.dart';
import '../Components/TopBar.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key, required this.user}) : super(key:key);
  final Users user;
  @override
  State<StatefulWidget> createState() => _walletPageState(user);
}

class _walletPageState extends State {
  _walletPageState(this.user);
  Users user;
  var money;
  var trans = <WalletTrans>[];
  var service = WalletService();

  Future<void> _veriGetir() async {
    trans = await service.getTransaction(user);
    money = await service.getMoney(user);
    setState(() {});
  }

  @override
  initState() {
    _veriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f5f7),
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 40),
        child: Center(
            child: Column(
          children: [
            TopBar(),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text("Cüzdanım",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                    Expanded(
                      child: money == null
                          ? Center(child: LoadAnim())
                          : Center(
                              child: Text(
                                money.toString() + " TL",
                                style: const TextStyle(
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
                        _veriGetir();
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
                child: ListView.builder(
                    itemCount: trans.length,
                    itemBuilder: (context, index) {
                      return item(trans[index]);
                    }),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget item(WalletTrans t) {
    if (t.transName == "MONEY_DEPOSIT") {
      return trans.isEmpty
          ? Center(child: LoadAnim())
          : ListTile(
              leading: const Icon(
                Icons.download_outlined,
                color: Colors.green,
              ),
              title: Text(t.date),
              trailing: Text(t.amount.toString() + "TL",
                  style: const TextStyle(fontSize: 18)),
            );
    } else {
      return trans.isEmpty
          ? Center(child: LoadAnim())
          : ListTile(
              leading: const Icon(
                Icons.upload_outlined,
                color: Colors.red,
              ),
              title: Text(t.date),
              trailing: Text(t.amount.toString() + "TL",
                  style: const TextStyle(fontSize: 18)),
            );
    }
  }
}
