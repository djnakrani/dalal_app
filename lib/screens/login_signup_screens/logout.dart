import 'package:dalal_app/screens/home_screens/home.dart';
import 'package:dalal_app/screens/login_signup_screens/login.dart';
import 'package:dalal_app/screens/login_signup_screens/splash_screen.dart';
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
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    if(FirebaseAuth.instance.currentUser!=null)
    {
      Get.offAll(Home());
    }
    else{
      Get.offAll(Login());
    }
  }
}

