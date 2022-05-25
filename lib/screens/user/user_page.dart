// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/Components/TopBar.dart';
import 'package:freelancer_market/screens/Components/loading.dart';
import 'package:freelancer_market/screens/login.dart';
import 'package:freelancer_market/screens/user/user_edit.dart';
import 'package:freelancer_market/screens/user/wallet_page.dart';

import '../../models/_User.dart';
import '../../service/auth/logoutService.dart';
import '../../service/user/userService.dart';
import '../AdvertPages/favori_adverts.dart';
import 'employer_edit.dart';
import 'myAdverts.dart';


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
  var logoutService = LogoutService();
  var u;

  Future<void> _veriGetir() async {
    u = await service.getUser();
    setState(() {});
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
      body: u == null
          ? Center(child: LoadAnim())
          : Column(
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
                            pro(u),
                            favorilerim(),
                            u.role != "ROLE_FREELANCER"
                                ? const Center()
                                : ilanlarim(),
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

  InkWell favorilerim() {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriAdverts(user:u)));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: const [
             Expanded(
              child: Icon(
                Icons.favorite,
                size: 35,
                color:Color(0xffe83c5f),
              ),
            ),
             Expanded(
              child: Text("Favorilerim",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
             Expanded(
                child: Icon(
              Icons.arrow_forward_ios,
              size: 35,
            )),
          ],
        ),
      ),
    );
  }

  InkWell ilanlarim() {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyAdverts(UserId:u.id)));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: const [
             Expanded(
              child: Icon(
                Icons.task_sharp,
                size: 35,
                color:Colors.orange
              ),
            ),
             Expanded(
              child: Text("İlanlarım",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
             Expanded(
                child: Icon(
              Icons.arrow_forward_ios,
              size: 35,
            )),
          ],
        ),
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

  Widget cikis() {
    return InkWell(
      onTap:(){
        logoutService.logout();
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: const [
            Expanded(
              child: Icon(
                Icons.logout,
                size: 35,
                color: Colors.red
              ),
            ),
            Expanded(
              child: Text("Çıkış yap",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Icon(
                Icons.arrow_forward_ios,
                size: 35,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sepetim() {
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: const [
            Expanded(
              child: Icon(
                Icons.shopping_basket,
                size: 35,
                color: Colors.grey
              ),
            ),
            Expanded(
              child: Text("Siparişlerim",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 35,
                ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell pro(var u) {
    return InkWell(
        onTap: () {
          if(u.role == "ROLE_FREELANCER"){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserEdit(UserId:u.id)));
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  EmployerEdit(UserId:u.id)));
          }
          
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
                  color:Colors.blueAccent
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WalletPage(user: u)));
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
                  color:Colors.green,
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
