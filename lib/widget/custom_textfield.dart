import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';


class CustomTextfield extends StatelessWidget{
  final String inputTxt;
  final TextInputType inputType;
  final IconData myIcon;
  final Function(String)? data ;
  final bool obscureText;
  const CustomTextfield({Key? key, required this.inputTxt, required this.inputType, required this.myIcon, this.data, this.obscureText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      keyboardType: inputType,
      obscureText: obscureText,
      decoration: InputDecoration(
          contentPadding:syv10,
          border: OutlineInputBorder(
            borderRadius: br20,
            ),
          hintText: inputTxt,
        prefixIcon: Icon(
          myIcon,
          color: myColors.colorPrimaryColor,
        ),
        hintStyle: TextStyle(color: Colors.grey[800]),
      ),
      onChanged: (value) {
        data;
      },
    );
  }
  
}