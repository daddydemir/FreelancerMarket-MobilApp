import 'package:flutter/material.dart';
import 'package:freelancer_market/data/dbHelper.dart';
import 'package:freelancer_market/screens/login.dart';

class Test13 extends StatefulWidget{
  const Test13({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _test13();
  }

}

// ignore: camel_case_types
class _test13 extends State{

  var db = DbHelper();
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body:Padding(
        padding:const EdgeInsets.all(10),
        child:Column(
          children:[
            const Center(child: Text("Demir"),),
            ElevatedButton(onPressed: (){
              print("Sonunu bildiğim bu yol önüme serdi bilinmez uçurumu");
              getDb();
            }, child: const Text("Click Me")),
            TextButton(onPressed: (){
              Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
            }, child: const Text("Login ol"),),
            ElevatedButton(onPressed:(){
              _dbDelete();
            },
            child:const Text("Sil"))
          ],
        ),
      ),
    );
  }

  void getDb(){
    var all = db.getUser();
    all.then((data) {
      for(int i=0;i<data.length;i++){
        print(data[i].mail + " : " + "\nToken : " + data[i].token);
      }
    });
  }

  void _dbDelete() {
    var sil = db.delete(23);
    sil.then((data){
      print("Response : " + data.toString());
    });
  }
}