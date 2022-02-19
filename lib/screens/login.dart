import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancer_market/api/auth_api.dart';
import 'package:freelancer_market/data/dbHelper.dart';
import 'package:freelancer_market/models/sql_user.dart';

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
  var login_api = AuthApi();
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
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xfffefefe), width: 2),
                  borderRadius: BorderRadius.circular(25),
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
    print("bu amk ");

    getJwtToken();
  }

  void getJwtToken() {
    AuthApi.login(username.text , password.text).then((response){
      setState((){
        if(response.statusCode == 200){
          var gelen = json.decode(utf8.decode(response.bodyBytes));
          
          var data = gelen["data"];
          var token = data["jwtToken"];
          var u1 = data["user"];
          //print(u1.toString());
          var kullanici = SqlUser(int.tryParse(u1["id"].toString()), u1["userName"],password.text, u1["name"],u1["surName"],u1["email"],u1["imagePath"]);
          kullanici.token = token;
          dbOperations(kullanici);
          var sqlResponse = database.getUser();
          sqlResponse.then((data){
            var ni = data[1];
            print("kAdı : " + ni.id.toString());
          });
        }else if(response.statusCode == 400){
          print("Parola yanlıs");
        }else{
          print(json.decode(utf8.decode(response.bodyBytes)));
        }
        
      });
    });
  }

  void dbOperations(SqlUser user){
    print("Kullanıcı kontorl ediliyor");
    var g = database.checkUser(user);
    g.then((data){
      if(data == null){
        print("veri yok , eklenecek");
        print(user.name);
        var fk = database.insert(user);
        fk.then((gelen){
          print("eklendi mi acaba "+gelen.toString());
          Fluttertoast.showToast(
            msg: "Eklendi : " + user.username,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
        });
      }else{
        print("zaten kullanıcı var");
      }
    });
  }
}
