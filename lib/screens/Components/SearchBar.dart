// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, avoid_print

import 'package:flutter/material.dart';

import '../../models/advert.dart';
import '../../service/advert/advertService.dart';
import '../AdvertPages/search.dart';

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _searchBarState();
  }

}

class _searchBarState extends State {
  var text = TextEditingController();
  var service = AdvertService();
  var liste = <Advert>[];
  
  search() async{
    liste = await service.getByFilter(text.text);
    print(liste.length.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => Search(liste:liste)));
  }

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
              controller: text,
              textInputAction: TextInputAction.search,
              onSubmitted: (value){
                search();
              },
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
                      search();
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