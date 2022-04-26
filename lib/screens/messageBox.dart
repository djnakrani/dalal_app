import 'dart:async';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageBox extends StatefulWidget {
  String msg;
  IconData icon;
  MessageBox({Key? key, required this.msg, required this.icon})
      : super(key: key);

  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: br20,
      ),
      elevation: 1,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 150,
          alignment: Alignment.center,
          padding: syh20v5 + syv10,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: br20,
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                  backgroundColor: myColors.colorPrimaryColor,
                  radius: 20,
                  child: Icon(widget.icon)),
              BoldText(
                widget.msg,
              ),
              const SizedBox(
                height: 22,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
