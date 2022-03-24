import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckAdmin extends StatefulWidget{
  @override
  _StateCheckAdmin createState() => _StateCheckAdmin();

 }

class _StateCheckAdmin extends State<CheckAdmin> {
  Object? data;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check();
  }
  @override
  Widget build(BuildContext context) {

    return Text(data.toString());

  }

  void _check() {
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    String uid = FirebaseAuth.instance.currentUser!.uid;

    var result = users.where("IsAdmin", isEqualTo: 1)
        .get();
  }

}
