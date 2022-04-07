import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancer_market/data/dbHelper.dart';
import 'package:freelancer_market/screens/AdvertPages/all_adverts.dart';
import 'package:freelancer_market/screens/StatusPage/server_error.dart';
import 'package:freelancer_market/screens/login.dart';
import 'package:freelancer_market/screens/temp/yorum_test.dart';

import '../Components/MyBottomBar.dart';
import 'advert_test.dart';
import 'image/imageUpload.dart';

class Test13 extends StatefulWidget {
  const Test13({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _test13();
  }
}

// ignore: camel_case_types
class _test13 extends State {
  var db = DbHelper();
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Center(
              child: Text("Demir"),
            ),
            ElevatedButton(
                onPressed: () {
                  getDb();
                },
                child: const Text("Click Me")),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text("Login ol"),
            ),
            ElevatedButton(
                onPressed: () {
                  _dbDelete();
                },
                child: const Text("Sil")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllAdverts()));
                },
                child: const Text("Sayfaya Git")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServerErrorPage()));
                },
                child: const Text("Error Page")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdvertTest()));
                },
                child: const Text("Advert Controller")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Yorum()));
                },
                child: const Text("Yorumlar kısmı")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ImageUpload()));
                },
                child: const Text("Resim Yükle")),
                ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyBottomBar()));
                },
                child: const Text("My Bottom Bar"))
          ],
        ),
      ),
    );
  }

  void getDb() {
    var all = db.getUser();
    all.then((data) {
      Fluttertoast.showToast(
          msg: data[0].id.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    });
  }

  void _dbDelete() {
    var sil1 = db.delete(23);
    var sil2 = db.delete(21);
    var sil3 = db.delete(29);
    sil1.then((data) {
      Fluttertoast.showToast(
          msg: "23 " + data.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    });

    sil2.then((data) {
      Fluttertoast.showToast(
          msg: "21 " + data.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    });
  }
}
