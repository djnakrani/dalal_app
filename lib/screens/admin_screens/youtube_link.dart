import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/home_screens/home.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:get/get.dart';

class InputYTLink extends StatefulWidget {
  const InputYTLink({Key? key}) : super(key: key);

  @override
  _InputYTLinkState createState() => _InputYTLinkState();
}

class _InputYTLinkState extends State<InputYTLink> {
  late String _Link;

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
                  child: const Text(" તમારા ની વિગત નાખો ",style: TextStyle(fontSize: 38),),
                  // child: Image.asset(Images.logoImage),
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
                    _Link = value;
                  },
                ),
              ),
              Container(
                margin: syv10 + syh20,
                child: CustomButton(
                  btnTxt: 'તમારી Link ઉમેરો ...',
                  callback: () {
                    Get.offAll(Home());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
