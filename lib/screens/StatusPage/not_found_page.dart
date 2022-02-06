import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

// https://raw.githubusercontent.com/daddydemir/images/main/Status/813.jpg
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://raw.githubusercontent.com/daddydemir/images/main/Status/813.jpg"),
              ),
            ),
          ),
          const Center(
            child: Text(
              "Bir hata meydana geldi !",
              style:TextStyle(fontSize:35,color:Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
