import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/screens/Input_screens/input_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/style.dart';

class ErrorScreen extends StatefulWidget {
  String error;
  ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child:AlertDialog(title: Text("Sample Alert Dialog"),)


      // insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        // child: Container(
        //     width: double.maxFinite,
        //     // child: Column(
        //     //   children: [
        //     //     Text(widget.error),
        //     //     ElevatedButton(
        //     //       onPressed: () {
        //     //         Get.back();
        //     //       },
        //     //       child: const Text(
        //     //         " Close ",
        //     //       ),
        //     //     )
        //     //   ],
        //     )
    );
  }
}
