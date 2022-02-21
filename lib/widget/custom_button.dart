import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';



class CustomButton extends StatelessWidget{
  final String btnTxt;
  final VoidCallback callback;
  const CustomButton({Key? key, required this.btnTxt, required this.callback}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: br20),
            primary: myColors.colorPrimaryColor),
        child: Container(
          padding: syv5,
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                btnTxt,
                style:
                TextStyle(color: myColors.btnTextColor),
              ),
              Container(
                padding: ah10,
                decoration: BoxDecoration(
                  borderRadius: br20,
                  color: myColors.colorPrimaryColor,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16,
                ),
              )
            ],
          ),
        ));
  }



}