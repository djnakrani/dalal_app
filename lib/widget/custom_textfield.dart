import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';


class CustomTextfield extends StatelessWidget{
  final String inputTxt;
  final TextInputType inputType;
  final int maxsize;
  final IconData myIcon;
  final Function(String)? voidReturn ;
  final bool obscureText;

  final int maxline;
  const CustomTextfield({Key? key, required this.inputTxt, required this.inputType, required this.myIcon,this.obscureText = false, this.maxsize = 100,required this.voidReturn, this.maxline = 1, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      maxLength: maxsize,
      maxLines: maxline,
      obscureText: obscureText,
      decoration: InputDecoration(
          contentPadding:syv10,
          counterText: '',
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
        voidReturn!(value);
      },
    );
  }
  
}