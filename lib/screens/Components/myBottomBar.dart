// ignore_for_file: unused_element, use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../main_page.dart';
import '../messages/chatUsers.dart';
import '../user/user_page.dart';

class MyBottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _myBottomBarState();
}

class _myBottomBarState extends State{
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          items:const [
            BottomNavigationBarItem(
              icon: Icon(Icons.workspaces_outline),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_sharp),
              label: 'User',
            ),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: Colors.transparent,
          selectedItemColor:const Color(0xff201a3d),
          unselectedItemColor: const Color(0xffe83c5f),
          onTap: _onItemTapped,
        );
  }

  void _onItemTapped(int value) {
    _selectedIndex = value;
    setState(() {});
    if(value == 0){
      Navigator.push(context,MaterialPageRoute(builder: (context) => const HomePage(),),);
    }else if(value == 1){
      Navigator.push(context,MaterialPageRoute(builder: (context) => const MainPage(),),);
    }else if(value == 2){
      Navigator.push(context,MaterialPageRoute(builder: (context) =>  ChatPage(),),);
    }else if(value == 3){
      Navigator.push(context,MaterialPageRoute(builder: (context) =>  UserPage(),),);
    }
  }
}