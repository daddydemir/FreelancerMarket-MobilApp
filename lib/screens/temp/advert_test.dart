// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/advert_api.dart';
import 'package:freelancer_market/data/dbHelper.dart';
import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/sql_user.dart';

class AdvertTest extends StatefulWidget {
  const AdvertTest({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _advertTestState();
}

class _advertTestState extends State {
  List<Advert> ilanlar = [];
  List<SqlUser> users = [];

  Future<void> _ilanSil(Advert advert) async {
    print("sil running");
    var db = DbHelper();
    var userlist = await db.getUser();
    users = userlist;
    setState((){});
    /* userlist.then((value) {
      users = value;
      setState((){});
    }); */
    var resp = await AdvertApi.Delete(advert, users[0]);
    print("Response Status Code : " + resp.statusCode.toString());
    var gelen = json.decode(utf8.decode(resp.bodyBytes));
    _ilanGetir();
  }

  Future<void> _ilanGetir() async {
    print("run");
    ilanlar.clear();
    var resp = await AdvertApi.getAllAdverts();
    if (resp.statusCode == 200) {
      var gelen = json.decode(utf8.decode(resp.bodyBytes));
      var data = gelen["data"];
      //print(data);
      for (var i in data) {
        ilanlar.add(Advert(
            i["id"],
            i["freelancerId"],
            i["subCategoryId"],
            i["title"],
            i["price"],
            i["info"],
            i["imagePath"],
            DateTime.parse(i["date"])));
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Advert"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _ilanGetir();
              },
              child: const Text("İlan getir"),
            ),
            ilanlar.isEmpty
                ? const Center(child: Text("Loading"))
                : Flexible(
                    child: ListView.builder(
                      itemCount: ilanlar.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap:(){
                            _ilanSil(ilanlar[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(ilanlar[index].title,
                                style: const TextStyle(fontSize: 18)),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
