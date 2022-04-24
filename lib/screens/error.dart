import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorScreen extends StatefulWidget {
  String error;
  ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), (){
      Get.back();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Text(widget.error.toString()),
    );

  }
}
