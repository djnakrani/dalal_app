import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/admin_screens/dashboard.dart';
import 'package:dalal_app/screens/home_screens/home.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_logo.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late String uid = "1";
  String? _mno;


  FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(FirebaseAuth.instance.currentUser?.uid != null){
    //   uid = FirebaseAuth.instance.currentUser!.uid;
    // _mno = FirebaseAuth.instance.currentUser!.phoneNumber;
    // }
    checkadmin();
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
          child: Column(
            children: <Widget>[
              const Center(
                child: CustomLogo(logoSize: 120.0,)
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
                  maxLine: 4,
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
                      "IsAdmin" : 0,
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
              Get.offAll(()=>Home());
            })
        .catchError((onError) {
      print(onError);
    });
  }

  void checkadmin() async {
    var collection = FirebaseFirestore.instance.collection('User');
    var docSnapshot = await collection.doc(uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data1 = docSnapshot.data();
      if(data1!['IsAdmin'].toString() == "1"){
        Get.offAll(()=>AdminDashboard());
      }
      else if(data1['IsAdmin'].toString() == "0"){
        Get.offAll(()=>Home());
      }
      else{
      }
    }
  }
}
