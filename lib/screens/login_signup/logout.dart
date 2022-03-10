import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/screens/home_screen/home.dart';
import 'package:dalal_app/screens/login_signup/login.dart';
import 'package:dalal_app/screens/login_signup/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:get/get.dart';

import '../../constants/Images.dart';

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.signOut();
    if(FirebaseAuth.instance.currentUser == null)
      {
        Get.offAll(SplashScreen());
      }
    else
      {
          print("Error");
      }

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
    if(FirebaseAuth.instance.currentUser!=null)
    {
      Get.offAll(home());
    }
    else{
      Get.offAll(Login());
    }
  }
}

