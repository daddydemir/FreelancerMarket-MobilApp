import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/Components/SearchBar.dart';
import 'package:freelancer_market/screens/Components/TopBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _homePageState();
  }
}

// ignore: camel_case_types
class _homePageState extends State {

  @override
  // ignore: must_call_super
  initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f5f7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(),
          SearchBar(),
          const Text(
            "En sevilen Freelancer'lar",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SizedBox(
              //width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return component();
                  }),
            ),
          ),
          const Text(
            "En Populer hizmetler",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return component();
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget component() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        elevation: 10,
        shadowColor: Colors.black,
        child: InkWell(
          splashColor: const Color(0xffe83c5f),
          onTap: () {},
          child: const SizedBox(
              width: 180,
              height: 200,
              child: Center(
                  child: RotationTransition(
                turns: AlwaysStoppedAnimation(45 / 360),
                child: Text(
                  "veri girilecek",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ))),
        ),
      ),
    );
  }

  Widget textCoponent(String mesaj) {
    return RotationTransition(
      turns: const AlwaysStoppedAnimation(45 / 360),
      child: Text(
        mesaj,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}
