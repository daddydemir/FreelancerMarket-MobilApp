import 'package:flutter/material.dart';

class TopBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _topBarState();
  }

}

class _topBarState extends State{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        top: 20,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Image(
          image:AssetImage('lib/assets/logo.png'),
          width:200,
        ),
        IconButton(
          iconSize: 35,
          icon: const Icon(Icons.add_alert),
          tooltip: "Alert Message",
          color: const Color(0xfffac45e),
          onPressed: () {
            //getCategories();
          },
        ),
      ]),
    );
  }
}