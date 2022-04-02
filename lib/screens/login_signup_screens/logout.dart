import 'package:dalal_app/screens/error.dart';
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
          ErrorScreen(error: 'Sorry Please Try Again',);
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Image.asset(Images.logoImage)));
  }
}

