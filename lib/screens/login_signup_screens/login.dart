import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/admin_screens/dashboard.dart';
import 'package:dalal_app/screens/error.dart';
import 'package:dalal_app/screens/home_screens/home.dart';
import 'package:dalal_app/screens/login_signup_screens/otp.dart';
import 'package:dalal_app/screens/login_signup_screens/signup.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_logo.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/Images.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String _mobileno;
  late SnackBar snackBar;
  final _LoginForm = GlobalKey<FormState>();

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
              Expanded(
                flex: 2,
                child: Column(
                  children: const <Widget>[
                    Center(
                        child: CustomLogo(
                      logoSize: 300.0,
                    )),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Form(
                  key: _LoginForm,
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 50,
                          margin: syh20v5,
                          child: CustomTextfield(
                            myIcon: Icons.call,
                            inputType: TextInputType.number,
                            inputTxt: 'તમારો મોબાઈલ નંબર નાખો....',
                            maxsize: 10,
                            voidReturn: (value) {
                              _mobileno = value;
                            },
                            validationData: (data) {
                              if (data.isEmpty) {
                                return "Mobile Number Required";
                              }
                              if(data.length < 10){
                                return "Not Valid Mobile Number";
                              }
                            },
                          )),
                      Container(
                        margin: syv10 + syh20,
                        child: CustomButton(
                            btnTxt: 'આગળ વધો',
                            callback: () {
                              if (_LoginForm.currentState!.validate()) {
                                Get.to(() => Otp(phone: _mobileno));
                              }
                            }),
                      ),
                      Container(
                        margin: syv10 + syh20,
                        child: CustomButton(
                            btnTxt: 'Test',
                            callback: () {
                              Get.to(() => Home());
                            }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
