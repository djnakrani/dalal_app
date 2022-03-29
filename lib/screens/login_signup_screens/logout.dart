import 'package:dalal_app/screens/home_screens/home.dart';
import 'package:dalal_app/screens/login_signup_screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/Images.dart';

class LogOut extends StatefulWidget {
  const LogOut({Key? key}) : super(key: key);

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
        Get.offAll(() => const Login());
      }
    else
      {
          print("Something went Wrong....");
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Image.asset(Images.logoImage)));
  }

  // void _navigatePage() async{
  //   await Future.delayed(const Duration(milliseconds: 2000), () {});
  //   if(FirebaseAuth.instance.currentUser!=null)
  //   {
  //     Get.offAll(() => Home());
  //   }
  //   else{
  //     Get.offAll(() => const Login());
  //   }
  // }
}

