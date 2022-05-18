// ignore_for_file: use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadAnim extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _loadAnimState();
}

class _loadAnimState extends State with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCube(
      color: const Color(0xffe83c5f),
      size: 50,
      controller: AnimationController(
          duration: const Duration(milliseconds: 600), vsync: this),
    );
  }
}
