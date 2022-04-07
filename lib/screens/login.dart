
import 'package:flutter/material.dart';
import 'package:freelancer_market/data/dbHelper.dart';

import '../service/auth/loginService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _loginState();
  }
}

// ignore: camel_case_types
class _loginState extends State {
  // ignore: non_constant_identifier_names
  var database = DbHelper();

  var username = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfaf4f5f7),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
        ),
        Center(
          child: Image.network(
            "https://raw.githubusercontent.com/daddydemir/images/main/freelancer-market/PNG-4x/icon.png",
            width: 200,
            height: 200,
            fit: BoxFit.fitWidth,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              controller: username,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfffefefe), width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfffefefe), width: 2),
                ),
                hintText: 'Kullanıcı Adı',
                fillColor: Color(0xfffefefe),
                filled: true,
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              controller:password,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xfffefefe), width: 2),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfffefefe), width: 2),
                ),
                hintText: 'Parola',
                fillColor: const Color(0xfffefefe),
                filled: true,
              ),
            ),
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SizedBox(
            height: 45,
            width: 150,
            child: TextButton(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff3a65aa)),
              ),
              onPressed: (){
                f_login();
              },
              child: const Text('Giriş Yap',
              style: TextStyle(
                fontSize:20,
              )),
            ),
          ),
        )),
      ]),
    );
  }

  // ignore: non_constant_identifier_names
  f_login() {
    var service = LoginService();
    service.login(username.text , password.text);
  }
}
