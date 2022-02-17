import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancer_market/data/dbHelper.dart';
import 'package:freelancer_market/screens/user/password_change.dart';

class UserEdit extends StatefulWidget {
  const UserEdit({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _userEditState();
  /*  {
    return _userEditState();
  } */
}

// ignore: camel_case_types
class _userEditState extends State {
  var db = DbHelper();
  var kontrol = [];
  var isim = "isim";
  var soyisim = "soyisim";
  // ignore: non_constant_identifier_names
  var kullanici_isim = "username";
  var parola = "parola";
  var hakkimda = "hakkimda";
  // ignore: non_constant_identifier_names
  String profil_resmi = "Profil_resmi";
  var url = "";

  Future<void> _veriGetir() async {
    var getir = db.getUser();
    getir.then((value) async {
      setState(() {
        kontrol = value;
        isim = value[0].name;
        soyisim = value[0].surname;
        parola = value[0].password;
        kullanici_isim = value[0].username;
        profil_resmi = value[0].image;
      });
    });
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
      body: kontrol.isEmpty
          ? const Center(child: Text("Ne Oldu"))
          : Padding(
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
                              Yazi("Ad"),
                              _isim(isim),
                              Yazi("Soyad"),
                              _soyisim(soyisim),
                              Yazi("Mail"),
                              _mail("mehmetcakmaktasi42@gmail.com"),
                              Yazi("Unvan"),
                              _unvan("Mobil Geliştirici"),
                              //Parola(),
                              //_parola(parola),
                              Yazi("Hakkımda"),
                              _hakkimda(hakkimda),
                              Parola(),
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
        textInputAction: TextInputAction.next,
        maxLines: null,
        minLines: 5,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE3E1E2), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE3E1E2), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: "Bu alan boş",
          fillColor: const Color(0xffE3E1E2),
          filled: true,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding Yazi(var name) {
    return  Padding(
        padding: const EdgeInsets.only(left: 20, top: 15),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Padding Parola() {
    return Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child:  InkWell(
          onTap:(){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PasswordChangePage()));
          },
          child: Row(
            children: const [
              Icon(
                Icons.security,
                size: 20,
                color: Colors.green,
              ),
               Padding(
                padding: EdgeInsets.only(left:8),
                child: Text(
                  "Parola'yı Güncelle",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Padding _unvan(var s) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE3E1E2), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE3E1E2), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: s,
          fillColor: const Color(0xffE3E1E2),
          filled: true,
        ),
      ),
    );
  }

  Padding _mail(var s) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE3E1E2), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE3E1E2), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: s,
          fillColor: const Color(0xffE3E1E2),
          filled: true,
        ),
      ),
    );
  }

  Padding _soyisim(var s) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE3E1E2), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE3E1E2), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: s,
          fillColor: const Color(0xffE3E1E2),
          filled: true,
        ),
      ),
    );
  }

  Padding _isim(var i) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE3E1E2), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE3E1E2), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: i,
          fillColor: const Color(0xffE3E1E2),
          filled: true,
        ),
      ),
    );
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
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
