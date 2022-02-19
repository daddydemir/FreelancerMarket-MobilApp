// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_element, deprecated_member_use, unused_local_variable, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/auth_api.dart';
import 'package:freelancer_market/data/dbHelper.dart';
import 'package:freelancer_market/models/sql_user.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _passwordChangePageState();
}

class _passwordChangePageState extends State {

  var lastpass = TextEditingController();
  var newpass = TextEditingController();
  var reptpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25, left: 12, right: 12),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          shadowColor: Colors.black,
          elevation: 20,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Yazi("Eski Parola"),
                  textbox(lastpass),
                  Yazi("Yeni Parola"),
                  textbox(newpass),
                  Yazi("Tekrar"),
                  textbox(reptpass),
                  Kaydet(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center Kaydet(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xff201a3d)),
          ),
          onPressed: () {
            changePass();
            //alertKutu(context);
          },
          child: const Text('KAYDET',
              style: TextStyle(
                fontSize: 20,
              )),
        ),
      ),
    );
  }

  Padding textbox(TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller:ctrl,
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
          fillColor: const Color(0xfff4f5f7),
          filled: true,
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

  void changePass() async{
    var db = DbHelper();
    var user;
    var getir = await db.getUser();
    user = getir[0];
    print(user.name+ " : " + newpass.text );
    var resp = await AuthApi.changePassword(user, lastpass.text, newpass.text, reptpass.text);
    var cevap = json.decode(utf8.decode(resp.bodyBytes));
    print(cevap);
    if(resp.statusCode == 200){
      var mesaj = cevap["message"];
      alertKutu(context,mesaj,true);
    }else{
      var mesaj = cevap["message"];
      alertKutu(context,mesaj,false);
    }

  }

  void alertKutu(BuildContext context,var mesaj,bool status) {
    Widget okButton = FlatButton(
        child: const Text("Tamam"),
        onPressed: () {
          //Navigator.of(context).pop();
          Navigator.pop(context);
          Navigator.pop(context);
        });

    AlertDialog alert = AlertDialog(
      title: const Text("Parola Durumu"),
      content: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Icon(
            Icons.info_outline,
            size: 25,
            color: status ? Colors.green :Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(left:8),
            child: Text(mesaj),
          ),
        ],
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
