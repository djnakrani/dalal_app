import 'dart:async';
import 'package:dalal_app/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageBox extends StatefulWidget {
  String msg;
  IconData icon;
  MessageBox({Key? key, required this.msg,required this.icon}) : super(key: key);

  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: br20,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
      // child: Text(widget.msg.toString()),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: syh20v5,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: br20,
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.msg,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.msg,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          right:10,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(20)),
                child: Icon(widget.icon)),
          ),
        ),
      ],
    );
  }
}
