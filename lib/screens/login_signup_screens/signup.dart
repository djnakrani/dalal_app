import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/home_screens/home.dart';
import 'package:dalal_app/screens/login_signup_screens/adminornot.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/Images.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key,}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<Signup> {
  late String _name;
  late String _email;
  late String _address;
  late String _city;
  late String _dist;
  late String _taluka;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final String? _mno = FirebaseAuth.instance.currentUser!.phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          // decoration: new BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage("Images/bg.jpg"), fit: BoxFit.fill)),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  margin: ot80,
                  child: Image.asset(Images.logoImage),
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5 + syv10,
                child: CustomTextfield(
                  myIcon: Icons.person,
                  inputType: TextInputType.text,
                  inputTxt: 'તમારું પૂરું નામ નાખો...',
                  voidReturn: (value) {
                    _name = value;
                  },
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5 + syv10,
                child: CustomTextfield(
                  myIcon: Icons.email,
                  inputType: TextInputType.emailAddress,
                  inputTxt: 'તમારું ઈ-મેલ નાખો....',
                  voidReturn: (value) {
                    _email = value;
                  },
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5 + syv10,
                child: CustomTextfield(
                  myIcon: Icons.location_city,
                  inputType: TextInputType.multiline,
                  maxline: 4,
                  inputTxt: 'તમારું સરનામું / ગામ નાખો. ',
                  voidReturn: (value) {
                    _address = value;
                  },
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5 + syv10,
                child: CustomTextfield(
                  myIcon: Icons.location_city,
                  inputType: TextInputType.text,
                  inputTxt: 'રાજ્ય',
                  voidReturn: (value) {
                    _dist = value;
                  },
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5 + syv10,
                child: CustomTextfield(
                  myIcon: Icons.location_city,
                  inputType: TextInputType.text,
                  inputTxt: 'જિલ્લો',
                  voidReturn: (value) {
                    _city = value;
                  },
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5 + syv10,
                child: CustomTextfield(
                  myIcon: Icons.location_city,
                  inputType: TextInputType.text,
                  inputTxt: 'તાલુકો',
                  voidReturn: (value) {
                    _taluka = value;
                  },
                ),
              ),
              Container(
                margin: syv10 + syh20,
                child: CustomButton(
                  btnTxt: 'આગળ વધો...',
                  callback: () {
                    Map<String, dynamic> data = {
                      "Name": _name,
                      "Address": _address,
                      "Mobile_no": _mno,
                      "Email": _email,
                      "District": _dist,
                      "Taluka": _taluka,
                      "City": _city,
                      "IsAdmin" : 1,
                    };
                    Add_User(data);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Add_User(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .set(data)
        .then((value) => () {
              Get.offAll(Home());
            })
        .catchError((onError) {
      print(onError);
    });
  }
}
