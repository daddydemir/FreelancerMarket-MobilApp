// ignore_for_file: camel_case_types, must_call_super

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/Advert-comment.dart';
import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/comments.dart';

class Yorum extends StatefulWidget {
  const Yorum({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _yorumState();
}

// ilan detay sayfasında dalan kullanılacak
class _yorumState extends State {
  List<Comments> yorumlar = [];
  var a = Advert(
      6,
      21,
      13,
      "Pentester",
      100,
      "Bu kısımda yaptığım işi anlatıyorum",
      "https://novasta.com.tr/wp-content/uploads/go-programlama-dili-gopher-novasta.png",
      DateTime.now());

  @override
  initState() {}

  Future<void> _veriGetir() async {
    yorumlar.clear();
    // 6. ilana yapılan yorumlar gelecek
    var ilanResp = await AdvertCommentApi.getByAdvertId(a);
    
    if (ilanResp.statusCode == 200) {
      var gelen = json.decode(utf8.decode(ilanResp.bodyBytes));
      var data = gelen["data"];
      for(var i in data){
        yorumlar.add(Comments.fromJson(i));
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yorumlar Sayfası"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            kutu(a),
            ElevatedButton(
                onPressed: () {
                  _veriGetir();
                }, child: const Text("Yorumları getir")),
            yorumlar.isEmpty
                ? const Center(child: Text("Henüz hiç yorum yapılmamış"))
                : Expanded(
                  //height:MediaQuery.of(context).size.height/3,
                  child: ListView.builder(
                      itemCount: yorumlar.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(yorumlar[index].content, style:const TextStyle(fontSize:18));
                      }),
                ),
          ],
        ),
      ),
    );
  }

  Card kutu(var ilan) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: Colors.black,
        elevation: 20,
        child: Column(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(ilan.image_path),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(padding: const EdgeInsets.all(8), child: Text(ilan.title)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(ilan.price.toString(),
                  style: const TextStyle(color: Colors.green)),
            )
          ]),
        ],
      ),
    );
  }
}
