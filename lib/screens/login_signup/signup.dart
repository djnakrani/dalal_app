import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/login_signup/login.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:get/get.dart';

import '../../constants/Images.dart';

class Signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}


class _signupState extends State<Signup> {
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
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 250),
                          margin: ot120,
                          child: Image.asset(Images.logoImage),
                        ),
                      ),
                    ),
                    // Container(
                    //     margin: const EdgeInsets.only(top: 10),
                    //     child: const Text('મહિલા કિસાન એપ',
                    //         style: TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 50,
                    //             fontWeight: FontWeight.w800)))
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      margin: syh20v5,
                      child: const CustomTextfield(myIcon: Icons.person, inputType: TextInputType.text, inputTxt: 'તમારું પૂરું નામ નાખો...',),
                    ),
                    Container(
                      height: 40,
                      margin: syh20v5,
                      child: const CustomTextfield(myIcon: Icons.email, inputType: TextInputType.emailAddress, inputTxt: 'તમારું ઈ-મેલ નાખો....',),
                    ),
                    Container(
                      height: 40,
                      margin: syh20v5,
                      child: const CustomTextfield(myIcon: Icons.phone, inputType: TextInputType.number, inputTxt: 'તમારો મોબાઈલ  નંબર નાખો...',),
                    ),Container(
                      height: 40,
                      margin: syh20v5,
                      child: const CustomTextfield(myIcon: Icons.password, inputType: TextInputType.text, inputTxt: 'તમારો નવો પાસવર્ડ નાખો ',obscureText: true,),
                    ),
                    Container(
                      margin: syh20,
                      child: CustomButton(
                        btnTxt: 'આગળ વધો...',
                        callback: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => Login())); }, ),
                    ),
                    Container(
                        margin:syh20v5,
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: MaterialButton(
                          child: const Text(
                            "લોગીન કરો.",
                            style: TextStyle(color: myColors.colorPrimaryColor),
                          ),
                          onPressed: () {
                            Get.off(Login());
                          },
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}