import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/home_screens/DetailScreen.dart';
import 'package:dalal_app/screens/login_signup_screens/signup.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  var _name,_email,_mno,_address,_city,_dist,_taluka;
  bool isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var uid = FirebaseAuth.instance.currentUser!.uid;
    Timer(const Duration(seconds: 1),(){
      setState(() {
        isloading = false;
      });
    });
    FirebaseFirestore.instance.collection('User').doc(uid).get().then((value) {
      setState(() {
        _name= value["Name"];
        _address= value["Address"];
        _mno= value["Mobile_no"];
        _email= value["Email"];
        _city= value["City"];
        _dist= value["District"];
        _taluka= value["Taluka"];

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.background), fit: BoxFit.fill)),
          height: MediaQuery.of(context).size.height,
          child:  Column(
            children: <Widget>[
              Center(
                child:Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  margin: ot80,
                  child: const Text(
                    " મારી વિગતો ",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
              isloading?const CircularProgressIndicator():Container(
                margin: ah10,
                padding: syv10+syh20,
                height: MediaQuery.of(context).size.height/2 ,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customDetails("નામ :", _name),
                    customDetails("ઈ-મેલ: ", _email),
                    customDetails("મોબાઇલ નંબર: ", _mno),
                    customDetails("સરનામું / ગામ: ", _address),
                    customDetails("તાલુકો: ", _taluka),
                    customDetails("જિલ્લો: ", _city),
                    customDetails("રાજ્ય: ", _dist),
                    Container(
                      margin: syv10 + syh20*5,
                      child: CustomButton(
                        btnTxt: 'Edit',
                        callback: () {
                          Get.to(() => const Signup());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dataTitleTable(String s, Color color) {
    return Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: br20,
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              s,
              style: const TextStyle(color: myColors.btnTextColor),
            ),
          ),
        ));
  }
}
