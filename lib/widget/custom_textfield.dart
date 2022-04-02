import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';

class CustomTextfield extends StatelessWidget {
  final String inputTxt;
  final TextInputType inputType;
  final int maxsize;
  final IconData myIcon;
  final Function(String)? voidReturn;
  final Function(String)? validationData;
  final bool obscureText;

  final int maxLine;
  const CustomTextfield({
    Key? key,
    required this.inputTxt,
    required this.inputType,
    required this.myIcon,
    this.obscureText = false,
    this.maxsize = 100,
    required this.voidReturn,
    this.maxLine = 1,
    required this.validationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      maxLength: maxsize,
      maxLines: maxLine,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: syv10,
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: br20,
        ),
        hintText: inputTxt,
        prefixIcon: Icon(
          myIcon,
          color: myColors.colorPrimaryColor,
        ),
        // hintStyle: TextStyle(color: Colors.grey[800]),
      ),
      validator: (value){
        return validationData!(value!);
      },
      onChanged: (value) {
        voidReturn!(value);
      },
    );
  }
}
