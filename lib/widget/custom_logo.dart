import 'package:dalal_app/constants/Images.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/style.dart';



class CustomLogo extends StatelessWidget{
  final double logoSize;
  const CustomLogo({Key? key,  required this.logoSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: logoSize),
      margin: ot80,
      child: Image.asset(Images.logoImage),
    );
  }
}