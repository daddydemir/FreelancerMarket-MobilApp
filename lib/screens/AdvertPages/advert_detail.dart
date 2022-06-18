// ignore_for_file: camel_case_types, use_key_in_widget_constructors, slash_for_doc_comments, no_logic_in_create_state, prefer_const_constructors_in_immutables, must_call_super, unnecessary_null_comparison, avoid_print, prefer_is_empty, prefer_typing_uninitialized_variables, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:freelancer_market/models/advert.dart';
import 'package:freelancer_market/models/comments.dart';
import 'package:freelancer_market/screens/Components/TopBar.dart';
import 'package:freelancer_market/screens/Components/loading.dart';

import '../../models/_User.dart';
import '../../models/commentResponse.dart';
import '../../models/freelancer.dart';
import '../../models/user.dart';
import '../../service/advert/advertService.dart';
import '../../service/commentService.dart';
import '../../service/orderService.dart';
import '../../service/user/freelancerService.dart';
import '../../service/user/userService.dart';

class AdvertDetailPage extends StatefulWidget {
  AdvertDetailPage({Key? key, required this.advert}) : super(key: key);

  final Advert advert;

  @override
  State<StatefulWidget> createState() => _advertDetailPageState(advert);
}
 // #TODO eğer bu adam sipariş vermişsse yorum yapabilecek onu kontrol etmem lazım.=> mesajgonderme = true; 
class _advertDetailPageState extends State {
  _advertDetailPageState(this.advert);

  final Advert advert;

  var as = AdvertService();
  var cs = CommentService();
  var fs = FreelancerService();
  var us = UserService();
  var os = OrderService();

  bool buttonDisable = false;
  var yorum = TextEditingController();
  var focusnode = FocusNode();
  bool mesajgonderme = false;

  List<CommentResponse> yorumyanitlar = [];
  List<Comments> yorumlar = [];
  List<User> yorumYapanlar = [];
  List<Advert> ilanlar = [];
  Users authUser = Users.empty();
  List temp = [];
  Freelancer owner = Freelancer.empty();

  @override
  initState() {
    _veriGetir();
  }

  yorumYapma() async {}

  siparisVerme() async {
    final snackbar;
    var status = await os.orderAdd(advert);
    if (status) {
      snackbar = const SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Text("Sipariş verildi, onay bekleniyor."));
      buttonDisable = true;
      setState(() {});
    } else {
      snackbar = const SnackBar(
        content: Text("Beklenmedik bir hata oldu, daha sonra tekrar deneyin."),
        backgroundColor: Colors.redAccent,
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  ilanGetir() async {
    ilanlar = await as.getAdvertByUserId(owner.id);
    setState(() {});
  }

  ownerGetir() async {
    authUser = await us.getUser();
    owner = await fs.getUser(advert.freelancer_id);
    setState(() {});
  }

  yorumGetir() async {
    temp = await cs.getByAdvertId(advert);
    yorumlar = temp[0];
    yorumYapanlar = temp[1];
    yorumyanitlar = temp[2];
    setState(() {});
  }

  void _veriGetir() async {
    await ownerGetir();
    await ilanGetir();
    await yorumGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ilanlar.isEmpty 
      ? Center(child: LoadAnim())
      : Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(),
                    kutu(advert),
                    information(advert),
                    siparisVer(),
                    owner == null ? Center(child: LoadAnim()) : userInfo(owner),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Freelancer'ın diğer ilanları",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    ilanlar.isEmpty
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: LoadAnim(),
                          ))
                        : Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              height: 260,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: ilanlar.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ilanItem(ilanlar[index]);
                                  }),
                            ),
                          ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Yorumlar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    yorumlar.isEmpty
                        ? Center(child: LoadAnim())
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 500,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: yorumlar.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    List<CommentResponse> temp =
                                        <CommentResponse>[];
                                    for (int i = 0;
                                        i < yorumyanitlar.length;
                                        i++) {
                                      if (yorumlar[index].id ==
                                          yorumyanitlar[i].advertCommentId) {
                                        temp.add(yorumyanitlar[i]);
                                      }
                                    }
                                    return yorumAlani(yorumlar[index], temp);
                                  }),
                            ),
                          ),
                          Visibility(
                            visible:true,
                            child: Stack(
                              children:[
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child:Container(
                                    padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                                    height: 60,
                                    width: double.infinity,
                                    color: Colors.white,
                                    child:Row(
                                      children:[
                                        Expanded(
                                          child:TextField(
                                            focusNode: focusnode,
                                            controller:yorum,
                                            decoration:InputDecoration(
                                              hintText: "görüşlerinizi belirtin . . .",
                                              hintStyle: TextStyle(color:Colors.black54),
                                              border:InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        FloatingActionButton(
                                          onPressed: (){
                                            print(yorum.text);
                                            yorum.clear();
                                          },
                                          child: Icon(
                                            Icons.send,
                                            color:Colors.white,
                                            size:18
                                          ),
                                          backgroundColor: Colors.blue,
                                          elevation:0
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget siparisVer() {
    if (advert.freelancer_id == authUser.id) {
      // kişi kendi ilanını sipariş veremez . . .
      return const SizedBox();
    } else {
      return Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 20,
        shadowColor: Colors.black,
        child: ElevatedButton(
          onPressed: buttonDisable
              ? null
              : () {
                  siparisVerme();
                },
          child: const Center(child: Text("Sipariş ver")),
        ),
      );
    }
  }

  Card kutu(Advert ilan) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: Colors.black,
      elevation: 20,
      child: Column(
        children: [
          Container(
            height: 200,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
                child: Text(ilan.title, style: const TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
                child: Text(ilan.price.toString() + " TL",
                    style: TextStyle(fontSize: 18, color: Colors.green[400])),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding information(Advert ilan) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        //height: 100,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: Colors.black,
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(ilan.info,
                style: const TextStyle(
                  fontSize: 15,
                )),
          ),
        ),
      ),
    );
  }

  Card userInfo(Freelancer user) {
    return Card(
      color: const Color(0xffe83c5f),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(29),
      ),
      shadowColor: Colors.black,
      elevation: 20,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 0,
            top: 0,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(30),
                child: Image.network(
                  user.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(user.username,
                      style: const TextStyle(
                          fontSize: 20, color: Color(0xff201a3d))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(user.appellation,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xff201a3d),
                      )),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Padding ilanItem(Advert advert) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black,
        elevation: 20,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width - 60,
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          icon: const Icon(Icons.favorite),
                          iconSize: 32,
                          color: const Color(0xffe83c5f),
                          onPressed: () {
                            
                          }),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(advert.title, style: const TextStyle(fontSize: 18)),
              ),
            ]),
      ),
    );
  }

  Widget yorumAlani(Comments comment, List<CommentResponse> liste) {
    User yorumyapan = User.empyt();
    for (int i = 0; i < yorumYapanlar.length; i++) {
      if (comment.userId == yorumYapanlar[i].id) {
        yorumyapan = yorumYapanlar[i];
      }
    }
    List<Widget> g = [];
    if (liste.length > 0) {
      for (int i = 0; i < liste.length; i++) {
        g.add(
          Row(children: [
            Expanded(
              flex:1,
              child: IconButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(focusnode);
                },
                icon: Icon(Icons.redo_outlined),
                iconSize: 35,
                color:Colors.red,
              ),
            ),
            Expanded(
              flex:5,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0, left:0),
                child: SizedBox(
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.black,
                    elevation: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 8, right: 8),
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(25),
                                  child: Image.network(
                                    liste[i].userId == yorumyapan.id
                                        ? yorumyapan.image
                                        : owner.imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 8, right: 8),
                              child: Text(
                                liste[i].userId == yorumyapan.id
                                    ? yorumyapan.username
                                    : owner.username,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SizedBox(
                                height: 50,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Card(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        liste[i].date,
                                        style:
                                            const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        const Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 15, bottom: 10, right: 10),
                          child: Text(
                            liste[i].content,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        );
      }
    }
    
    Column gonder = Column(
      children: g,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          SizedBox(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              shadowColor: Colors.black,
              elevation: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(30),
                            child: Image.network(
                              yorumyapan.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Text(
                          yorumyapan.username,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Card(
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 8, bottom: 8, right: 8),
                                child: Text(comment.date.toString(),
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  const Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 15, bottom: 10, right: 10),
                    child: Text(comment.content,
                        style: const TextStyle(fontSize: 15)
                        //overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ],
              ),
            ),
          ),
          gonder,
        ],
      ),
    );
  }
}