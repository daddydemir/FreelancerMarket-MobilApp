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
        Image.network(
          "https://raw.githubusercontent.com/daddydemir/images/main/freelancer-market/PNG-4x/acik-zemin%404x.png",
          width: 200,
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