import 'package:flutter/material.dart';

class Sil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _silState();
  }
}

class _silState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return component();
            }),
      ),
    );
  }

  Widget component() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: Colors.white,
        elevation: 10,
        shadowColor: Colors.black,
        child: InkWell(
          splashColor: Colors.amberAccent,
          onTap: () {
            print(MediaQuery.of(context).size.width.toString());
          },
          child: const SizedBox(
              width: 180,
              height: 200,
              child: Center(child: Text("@daddydemir"))),
        ),
      ),
    );
  }
}
