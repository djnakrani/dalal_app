import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/login_signup_screens/otp.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/Images.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}


class _loginState extends State<Login> {
  late String _mobileno;

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
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 300),
                        margin: ot120,
                        child: Image.asset(Images.logoImage),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      margin: syh20v5,
                      child: CustomTextfield(
                        myIcon: Icons.call,
                        inputType: TextInputType.number,
                        inputTxt: 'તમારો મોબાઈલ નંબર નાખો ....',
                        maxsize: 10,
                        voidReturn: (value){
                          _mobileno =value;
                        },
                      )
                    ),
                    Container(
                        margin: syv10 + syh20,
                        child: CustomButton(btnTxt: 'આગળ વધો', callback: () {
                          Get.to(Otp(phone:  _mobileno));
                        }),
                    ),
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