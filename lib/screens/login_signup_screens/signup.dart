import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/home_screens/home.dart';
import 'package:dalal_app/screens/messageBox.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_logo.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/Images.dart';

class Signup extends StatefulWidget {
  const Signup({
    Key? key,
  }) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? _name,_email,_address,_city,_dist,_taluka;
  String? uid;
  String? _mno;
  final _signUpForm = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    if(FirebaseAuth.instance.currentUser?.uid != null){
      uid = FirebaseAuth.instance.currentUser!.uid;
     _mno = FirebaseAuth.instance.currentUser!.phoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.background), fit: BoxFit.fill)),
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _signUpForm,
            child: Column(
              children: <Widget>[
                const Center(
                    child: CustomLogo(
                  logoSize: 120.0,
                )),
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
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "This Field is Required..";
                      }
                      if (RegExp(r'^[a-z A-Z]+$').hasMatch(data)) {
                        return "Only Character Allowed...";
                      }
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
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "This Field is Required..";
                      }
                      if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(data)) {
                        return "Enter Valid Email...";
                      }
                    },
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5 + syv10,
                  child: CustomTextfield(
                    myIcon: Icons.location_city,
                    inputType: TextInputType.multiline,
                    maxLine: 4,
                    inputTxt: 'તમારું સરનામું / ગામ નાખો. ',
                    voidReturn: (value) {
                      _address = value;
                    },
                    validationData: (data) {},
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
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "This Field is Required..";
                      }
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
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "This Field is Required..";
                      }
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
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "This Field is Required..";
                      }
                    },
                  ),
                ),
                Container(
                  margin: syv10 + syh20,
                  child: CustomButton(
                    btnTxt: 'આગળ વધો...',
                    callback: () {
                      if (_signUpForm.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          "Name": _name,
                          "Address": _address,
                          "Mobile_no": _mno,
                          "Email": _email,
                          "District": _dist,
                          "Taluka": _taluka,
                          "City": _city,
                          "IsAdmin": "0",
                        };
                        addUsers(data);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addUsers(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .set(data)
        .then((value) => () {
              Get.offAll(() => const Home());
            })
        .catchError((onError) {
          MessageBox(msg: onError.toString(),icon: Icons.error,);
    });
  }
}
