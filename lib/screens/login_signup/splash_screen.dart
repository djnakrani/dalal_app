import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/screens/login_signup/login.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:get/get.dart';

import '../../constants/Images.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
    child: Container(
      // constraints: const BoxConstraints(maxHeight: 250),
      // margin: ot120,
      child: Image.asset(Images.logoImage),
    )));
  }

  void _navigatePage() async{
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Get.offAll(Login());
  }
}

