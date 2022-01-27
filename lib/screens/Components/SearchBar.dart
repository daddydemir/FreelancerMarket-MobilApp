import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _searchBarState();
  }

}

class _searchBarState extends State {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, top: 5.0, right: 10, bottom: 10),
          child: PhysicalModel(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            elevation: 20,
            shadowColor: Colors.black,
            child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xfffefefe), width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xfffefefe), width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Neye ihtiyacın var ?',
                  fillColor: const Color(0xfffefefe),
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      print("Ara bakalım");
                    },
                    icon: const Icon(Icons.search),
                    color: Colors.black,
                    iconSize: 30,
                  )),
            ),
          )),
    );
  }
}