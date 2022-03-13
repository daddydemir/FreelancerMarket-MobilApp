import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/Components/TopBar.dart';
import 'package:freelancer_market/screens/Components/loading.dart';
import 'package:freelancer_market/screens/user/user_edit.dart';
import 'package:freelancer_market/screens/user/wallet_page.dart';

import '../../models/_User.dart';
import '../../service/user/userService.dart';

// ignore: use_key_in_widget_constructors
class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _userPageState();
  }
}

// ignore: camel_case_types
class _userPageState extends State {

  var service = UserService();
  var u;

  Future<void> _veriGetir() async {
    u = await service.getUser();
    setState((){});
  }

  @override
  // ignore: must_call_super
  initState() {
    _veriGetir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f5f7),
      body: u == null ? Center(child:LoadAnim()) : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(),
          kolonIn(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              shadowColor: Colors.black,
              elevation: 20,
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 190,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Color(0xffe83c5f),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Center(
                            child: Row(children: [
                              ClipOval(
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(40),
                                  child: Image.network(
                                    u.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              userInfo(u),
                            ]),
                          ),
                        ),
                      ),
                      pro(),
                      u.role != "ROLE_FREELANCER" ? const Center() : ilanlarim(),
                      sepetim(),
                      cuz(),
                      cikis(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

Padding ilanlarim() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.task_sharp),
              iconSize: 35,
              tooltip: "Text(" "),",
              onPressed: () {},
            ),
          ),
          const Expanded(
            child: Text("İlanlarım",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
              child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            iconSize: 35,
            onPressed: () {},
          )),
        ],
      ),
    );
  }

  Padding userInfo(Users user) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(user.username,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(user.mail, style: const TextStyle(fontStyle: FontStyle.italic))
          ]),
    );
  }

  Padding cikis() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.logout),
              iconSize: 35,
              tooltip: "Text(" "),",
              onPressed: () {},
            ),
          ),
          const Expanded(
            child: Text("Çıkış yap",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
              child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            iconSize: 35,
            onPressed: () {},
          )),
        ],
      ),
    );
  }

  Padding sepetim() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.shopping_basket),
              iconSize: 35,
              tooltip: "Text(" "),",
              onPressed: () {},
            ),
          ),
          const Expanded(
            child: Text("Sepetim",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
              child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            iconSize: 35,
            onPressed: () {},
          )),
        ],
      ),
    );
  }

  InkWell pro() {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserEdit()));
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Expanded(
                child: Icon(
                  Icons.person_sharp,
                  size: 35,
                ),
              ),
              const Expanded(
                child: Text("Profilim",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const Expanded(
                  child: Icon(
                Icons.arrow_forward_ios,
                size: 35,
              )),
            ],
          ),
        ));
  }

  InkWell cuz() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WalletPage(user:u)));
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Expanded(
                child: Icon(
                  Icons.attach_money_sharp,
                  size: 35,
                ),
              ),
              const Expanded(
                child: Text("Cüzdanım",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const Expanded(
                  child: Icon(
                Icons.arrow_forward_ios,
                size: 35,
              )),
            ],
          ),
        ));
  }

  Padding kolonIn() {
    return const Padding(
      padding: EdgeInsets.all(10),
    );
  }
}
