import 'package:dalal_app/screens/error.dart';
import 'package:dalal_app/screens/login_signup_screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

LogOut() {
  FirebaseAuth.instance.signOut();
  if (FirebaseAuth.instance.currentUser == null) {
    Get.offAll(() => const Login());
  }
  else {
    ErrorScreen(error: 'Sorry Please Try Again',);
  }
}