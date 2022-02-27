// ignore_for_file: empty_constructor_bodies

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_market/api/freelancer_api.dart';
import 'package:freelancer_market/models/freelancer.dart';
import 'package:freelancer_market/screens/Components/TopBar.dart';

class FreelancerDetailPage extends StatefulWidget {
  const FreelancerDetailPage({Key? key, required this.user}): super(key: key);
  final Freelancer user;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _freelancerDetailPageState(user);
}

// ignore: camel_case_types
class _freelancerDetailPageState extends State {
  _freelancerDetailPageState(this.user);
  final Freelancer user;

  @override
  initState() {
    //_veriGetir();
  }

  Future<void> _veriGetir() async {
    var userResp = await FreelancerApi.getById(user.id);
    if (userResp.statusCode == 200) {
      var gelen = json.decode(utf8.decode(userResp.bodyBytes));
      var data = gelen["data"];
      //user = Freelancer.fromJson(data);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfaf4f5f7),
      body: Column(children: [
        TopBar(),
        user == null
            ? const Center(child: Text("Loading"))
            : Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        resim(user),
                        const Padding(padding: EdgeInsets.all(5)),
                        info(user),
                        info(user),
                        info(user),
                      ],
                    ),
                  ),
                ),
              ),
      ]),
    );
  }

  Card info(Freelancer user) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: const Center(
              child: Text("Tamamlanan Sipariş"),
            ),
          ),
        ],
      ),
    );
  }

  Card resim(Freelancer user) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Center(
              child: ClipOval(
                  child: SizedBox.fromSize(
                size: const Size.fromRadius(70),
                child: Image.network(user.imagePath, fit: BoxFit.cover),
              )),
            ),
          ),
          Text(
            user.name + " " + user.surname,
            style: const TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user.appellation),
          ),
        ],
      ),
    );
  }
}
