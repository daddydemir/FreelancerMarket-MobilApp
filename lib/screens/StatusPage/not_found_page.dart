import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40,bottom:40),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Image.network(
                  "https://raw.githubusercontent.com/daddydemir/images/main/Status/error-404.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20,vertical:10),
            child: Container(
              child:const  Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Bazen insanları anlamak çok zor ...",
                    style: TextStyle(fontSize: 20, color: Colors.white,),
                    
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:Colors.pink,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:100),
            child: Container(
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:Colors.black87,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("GERİ DÖN", style:TextStyle(fontSize: 25,color:Colors.white,)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
