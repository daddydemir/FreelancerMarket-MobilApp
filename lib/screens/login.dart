import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/login_api.dart';
import 'package:freelancer_market/data/dbHelper.dart';
import 'package:freelancer_market/models/sql_user.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _loginState();
  }
}

class _loginState extends State {
  var login_api = LoginApi();
  var database = DbHelper();
  var sql_user = SqlUser.empty();

  var username = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfaf4f5f7),
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
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
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
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
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextField(
                controller:password,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfffefefe), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfffefefe), width: 2),
                  ),
                  hintText: 'Parola',
                  fillColor: Color(0xfffefefe),
                  filled: true,
                ),
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SizedBox(
              height: 45,
              width: 150,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff3a65aa)),
                ),
                onPressed: (){
                  f_login();
                },
                child: Text('Giriş Yap',
                style: TextStyle(
                  fontSize:20,
                )),
              ),
            ),
          )),
        ]),
      ),
    );
  }

  f_login() {
    getJwtToken();
  }

  void getJwtToken() {
    LoginApi.getJwtToken(username.text , password.text).then((response){
      setState((){
        if(response.statusCode == 200){
          var gelen = json.decode(utf8.decode(response.bodyBytes));
          var token = gelen["jwtToken"];
          var u1 = gelen["user"];
          //print(u1.toString());
          var kullanici = SqlUser(int.tryParse(u1["id"].toString()), u1["userName"],password.text);
          kullanici.token = token;
          //kullanici.id = 1;
          // gelen veri ile kullanıcı oluşturuldu 
          // veri tabanına eklenecek 
          //var sql_response = database.insert(kullanici);
          dbOperations(kullanici);
          var sql_response = database.getUser();
          sql_response.then((data){
            var ni = data[1];
            print("kAdı : " + ni.id.toString());
          });
          
          
        }else if(response.statusCode == 400){
          print("Parola yanlıs");
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
        var fk = database.insert(user);
        fk.then((gelen){
          print("eklendi mi acaba "+gelen.toString());
        });
      }else{
        print("zaten kullanıcı var");
      }
    });
  }
}
