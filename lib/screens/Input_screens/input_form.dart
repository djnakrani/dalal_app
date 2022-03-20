import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/home_screens/home.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:get/get.dart';

class InputForm extends StatefulWidget {
  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  late String _title;
  late String _discpt;
  late String _address;
  late String _city;
  late String _dist;
  late String _taluka;
  late String _price;


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
                  child: Text("તમે શું વેચવા માંગો છો?",style: TextStyle(fontSize: 40),),
                  // child: Image.asset(Images.logoImage),
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5 + syv10,
                child: CustomTextfield(
                  myIcon: Icons.title,
                  inputType: TextInputType.text,
                  inputTxt: 'શીર્ષક',
                  voidReturn: (value) {
                    _title = value;
                  },
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5 + syv10,
                child: CustomTextfield(
                  myIcon: Icons.title,
                  inputType: TextInputType.text,
                  inputTxt: 'કિંમત  ',
                  voidReturn: (value) {
                    _price = value;
                  },
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5,
                child: CustomTextfield(
                  myIcon: Icons.title,
                  inputType: TextInputType.text,
                  inputTxt: 'વર્ણન ',
                  voidReturn: (value) {
                    _discpt = value;
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
                margin: syh20v5 + syv10,
                padding: a40,
                decoration: BoxDecoration(
                    border: Border.all(color: myColors.colorPrimaryColor)
                ),
                child: const Icon(
                  Icons.add_a_photo,
                  color: myColors.colorPrimaryColor,
                ),
              ),
              Container(
                margin: syv10 + syh20,
                child: CustomButton(
                  btnTxt: 'તમારી પોસ્ટ ઉમેરો ...',
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
