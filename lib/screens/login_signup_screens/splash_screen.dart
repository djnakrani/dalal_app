import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/screens/admin_screens/dashboard.dart';
import 'package:dalal_app/screens/home_screens/home.dart';
import 'package:dalal_app/screens/login_signup_screens/login.dart';
import 'package:dalal_app/screens/login_signup_screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/Images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
            child: Image.asset(Images.logoImage)));
  }

  void _navigatePage() async{
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    if(FirebaseAuth.instance.currentUser!=null)
    {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('User').doc(uid).get().then((value) {
        if(value["IsAdmin"] == "1"){
          Get.offAll(() => const AdminDashboard());
        }
        else if(value["IsAdmin"] == "")
        {
          Get.offAll(() => const Signup());
        }
        else{
          
          Get.offAll(() => const Home());
        }
      });
    }
    else{
      Get.offAll(() => const Login());
    }
  }

  getAdmin() async {

    return "hello";
    // Get.log(_type);
  }
}

