import 'package:dalal_app/screens/error.dart';
import 'package:dalal_app/screens/login_signup_screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget LogOut() {
  FirebaseAuth.instance.signOut();
  if (FirebaseAuth.instance.currentUser == null) {
    return const Login();

  }
  else {
    return ErrorScreen(error: 'Sorry Please Try Again',);
  }
}