import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/home_screen/home.dart';
import 'package:dalal_app/screens/login_signup/signup.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:get/get.dart';

import '../../constants/Images.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}


class _loginState extends State<Login> {
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
                        constraints: const BoxConstraints(maxHeight: 250),
                        margin: ot120,
                        child: Image.asset(Images.logoImage),
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
                      child: const CustomTextfield(myIcon: Icons.email, inputType: TextInputType.emailAddress, inputTxt: 'તમારું ઈ-મેલ નાખો....',)
                    ),
                    Container(
                      height: 40,
                      margin: syh20v5,
                        child: const CustomTextfield(myIcon: Icons.password, inputType: TextInputType.text, inputTxt: 'તમારો પાસવર્ડ નાંખો...',obscureText: true,)
                    ),
                    Container(
                        margin: syh20,
                        alignment: Alignment.topRight,
                        child: MaterialButton(
                          child: const Text(
                            "પાસવર્ડ ભુલાઈ ગયો?",
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {},
                        )),
                    Container(
                        margin: syh20,
                        child: CustomButton(btnTxt: 'આગળ વધો', callback: () {
                          Get.off(home());
                        }),
                    ),
                    Container(
                        margin: syh20v5,
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: MaterialButton(
                          child: const Text(
                            "નવું એકાઉન્ટ બનાવો?",
                            style: TextStyle(color: myColors.colorPrimaryColor),
                          ),
                          onPressed: () {
                            Get.off(Signup());
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