import 'package:flutter/material.dart';

double regularSize = 18;
Widget SimpleText(text){
  return Text(
    text,
    style: TextStyle(fontSize: regularSize),
  );
}

Widget BoldText(text){
  return Text(
      text,
    style: TextStyle(fontWeight: FontWeight.bold,fontSize: regularSize),
  );
}