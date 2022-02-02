import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancer_market/data/dbHelper.dart';

class UserEdit extends StatefulWidget {
  const UserEdit({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _userEditState();
  }
}

// ignore: camel_case_types
class _userEditState extends State {
  var db = DbHelper();
  var isim = "isim";
  var soyisim = "soyisim";
  // ignore: non_constant_identifier_names
  var kullanici_isim = "username";
  var parola = "parola";
  var hakkimda = "hakkimda";
  // ignore: non_constant_identifier_names
  String profil_resmi = "Profil_resmi";
  var url =
      "https://im.haberturk.com/2014/06/27/ver1578211859/962619_414x414.jpg";

  @override
  // ignore: must_call_super
  initState() {
    var getir = db.getUser();
    getir.then((value) {
      isim = value[0].name;
      soyisim = value[0].surname;
      parola = value[0].password;
      kullanici_isim = value[0].username;
      setState(() {
        profil_resmi = value[0].image;
      });
      /* Fluttertoast.showToast(
            msg: profil_resmi,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1); */
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f5f7),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 7, top: 7, right: 7),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
            shadowColor: Colors.black,
            elevation: 20,
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        resim(profil_resmi),
                        kullaniciIsmi(kullanici_isim),
                        Isim(),
                        _isim(isim),
                        Soyisim(),
                        _soyisim(soyisim),
                        Parola(),
                        _parola(parola),
                        Hakkimda(),
                        _hakkimda(hakkimda),
                        Kaydet(),
                      ]),
                )),
          ),
        )),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Center Kaydet() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xff201a3d)),
          ),
          onPressed: () {},
          child: const Text('KAYDET',
              style: TextStyle(
                fontSize: 20,
              )),
        ),
      ),
    );
  }

  Padding _hakkimda(var h) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: TextField(
        maxLines: null,
        minLines: 5,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfffefefe), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfffefefe), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: "Bu alan boş",
          fillColor: Colors.blueGrey[100],
          filled: true,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding Hakkimda() {
    return const Padding(
        padding: EdgeInsets.only(left: 20, top: 20),
        child: Text(
          "Hakkımda",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ));
  }

  Padding _parola(var p) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfffefefe), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfffefefe), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: p,
          fillColor: Colors.blueGrey[100],
          filled: true,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding Parola() {
    return const Padding(
        padding: EdgeInsets.only(left: 20, top: 20),
        child: Text(
          "Parola",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ));
  }

  Padding _soyisim(var s) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfffefefe), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfffefefe), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: s,
          fillColor: Colors.blueGrey[100],
          filled: true,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding Soyisim() {
    return const Padding(
        padding: EdgeInsets.only(left: 20, top: 20),
        child: Text(
          "Soyad",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ));
  }

  Padding _isim(var i) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfffefefe), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfffefefe), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: i,
          fillColor: Colors.blueGrey[100],
          filled: true,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding Isim() {
    return const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text(
          "Ad",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ));
  }

  Center kullaniciIsmi(var k) {
    //doldur();
    return Center(
      child: Text(
        k,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Center resim(String pr) {
    return Center(
      child: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(70),
          child: Image.network(
            pr,
          ),
        ),
      ),
    );
  }

  void doldur() async {
    var getir = db.getUser();
    getir.then((value) async {
      setState(() {
        isim = value[0].name;
        soyisim = value[0].surname;
        parola = value[0].password;
        kullanici_isim = value[0].username;
        profil_resmi = value[0].image;
        print("oldu : " + value[0].name);
        Fluttertoast.showToast(
            msg: profil_resmi,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      });
    });
  }
}
