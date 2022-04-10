import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  String error;
  ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: Text("Hello"),
    );
  }
}
