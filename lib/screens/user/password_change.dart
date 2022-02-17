// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_element

import 'package:flutter/material.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _passwordChangePageState();
}

class _passwordChangePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:25,left:12,right:12),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          shadowColor: Colors.black,
          elevation: 20,
          child: SizedBox(
            width:MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Yazi("Eski Parola"),
                  _parola1(),
                  Yazi("Yeni Parola"),
                  _parola1(),
                  Yazi("Tekrar"),
                  _parola1(),
                  Kaydet(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  Padding _parola1() {
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
          fillColor: const Color(0xffE3E1E2),
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
}
