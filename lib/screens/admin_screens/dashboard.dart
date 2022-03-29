import 'package:dalal_app/screens/Input_screens/take_screen.dart';
import 'package:dalal_app/screens/admin_screens/adminDrawer.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/constants/string.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(string.appName),
        backgroundColor: myColors.colorPrimaryColor,
      ),
      drawer: AdminDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return MyCard("Color","Categoty Name","Icon","Number");
            }),
      ),
      );
  }
}

Widget MyCard(String color,String category,String icon,String number,) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40), // if you need this
      side: BorderSide(
        color: Colors.green.withOpacity(0.2),
        width: 1,
      ),
    ),
    child: Container(
      color: Colors.white,
      width: 200,
      height: 300,
      child: Text(category),
    ),
  );
}
