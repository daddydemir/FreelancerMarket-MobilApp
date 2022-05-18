// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, no_logic_in_create_state, camel_case_types, must_call_super

import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/user/password_change.dart';

import '../../service/user/employerService.dart';
import '../Components/loading.dart';

class EmployerEdit extends StatefulWidget {
  EmployerEdit({Key? key, required this.UserId}) : super(key: key);

  var UserId;

  @override
  State<StatefulWidget> createState() => _employerEdit(UserId);
}

class _employerEdit extends State {
  _employerEdit(this.index);
  var index;
  var service = EmployerService();
  var u;

  Future<void> _veriGetir() async {
    u = await service.getUser(index);
    setState(() {});
  }

  @override
  initState() {
    _veriGetir();
  }

  Center resim(String pr) {
    return Center(
      child: Stack(children: [
        Align(
          child: ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(70),
              child: Image.network(
                pr,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 110),
          child: Align(
            alignment: Alignment.topCenter,
            child: IconButton(
                icon: const Icon(Icons.add_a_photo_outlined),
                iconSize: 40,
                color: const Color(0xffe83c5f),
                onPressed: () {}),
          ),
        ),
      ]),
    );
  }

  Center kullaniciIsmi(var k) {
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

  Padding Yazi(var name) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, top: 15),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ));
  }

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
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: h,
          fillColor: const Color(0xfff4f5f7),
          filled: true,
        ),
      ),
    );
  }

  Padding Parola(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PasswordChangePage()));
          },
          child: Row(
            children: const [
              Icon(
                Icons.security,
                size: 20,
                color: Colors.green,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
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

  Padding _mail(var s) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: s,
          fillColor: const Color(0xfff4f5f7),
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
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: s,
          fillColor: const Color(0xfff4f5f7),
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
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: i,
          fillColor: const Color(0xfff4f5f7),
          filled: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: u == null
          ? Center(child: LoadAnim())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
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
                            resim(u.imagePath),
                            kullaniciIsmi(u.username),
                            Yazi("İsim"),
                            _isim(u.name),
                            Yazi("Soyad"),
                            _soyisim(u.surname),
                            Yazi("Mail"),
                            _mail(u.email),
                            Yazi("Hakkımda"),
                            _hakkimda(u.about),
                            Parola(context),
                            Kaydet(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
