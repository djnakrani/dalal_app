import 'package:dalal_app/screens/login_signup_screens/login.dart';
import 'package:dalal_app/screens/messageBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget LogOut() {
  FirebaseAuth.instance.signOut();
  // if (FirebaseAuth.instance.currentUser == null) {
    return const Login();
  // }
  // else {
  //   return MessageBox(msg: 'Sorry Please Try Again', icon: Icons.error,);
  // }
}