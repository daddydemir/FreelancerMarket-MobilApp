import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/home/home_page.dart';
import 'package:freelancer_market/screens/main_page.dart';
import 'package:freelancer_market/screens/user/user_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _navBarState();
  }
}

// ignore: camel_case_types
class _navBarState extends State {
  int _selectedIndex = 0;
  final ekran = HomePage();
  _changeScreen(){
    if(_selectedIndex == 0){
      return HomePage();
    }
    else if(_selectedIndex ==1){
      return MainPage();
    }
    else if(_selectedIndex == 3){
      return UserPage();
    }
    else if(_selectedIndex == 4){
      return UserPage();
    }
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _changeScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _changeScreen(), //_widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        items: metod1,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff201a3d),
        unselectedItemColor: const Color(0xffe83c5f),
        onTap: _onItemTapped,
      ),
    );
  }

  List<BottomNavigationBarItem> get metod1 {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.business_center),
        label: "Categories",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.home), label: 'Home',
      ),
      const BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
      const BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'User '),
    ];
  }
  
}
