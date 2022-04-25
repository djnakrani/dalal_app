import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/admin_screens/adminDrawer.dart';
import 'package:dalal_app/widget/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/string.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String totalUser= "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      setState(() {
        totalUser = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(string.appName),
        backgroundColor: myColors.colorPrimaryColor,
      ),
      drawer: const AdminDrawer(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                MyCard(Colors.amberAccent, "User","https://firebasestorage.googleapis.com/v0/b/dalal-163d2.appspot.com/o/icon-g04b495cfe_1920.png?alt=media&token=44074bbb-08ec-401d-85ad-541b71553c4e", totalUser),
                MyCard(Colors.green, "Pasu", "https://firebasestorage.googleapis.com/v0/b/dalal-163d2.appspot.com/o/Category%2F1.png?alt=media&token=eb453c7a-c0df-4971-9532-d1ae71c8df79", totalUser),
                MyCard(Colors.white54, "Categoty Name", "Icon", totalUser),
                MyCard(Colors.white54, "Categoty Name", "Icon", totalUser),
              ],
            )
            ),
      ),
    );
  }

  Widget MyCard(
    Color cardcolor,
    String category,
    String image,
    String number,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40), // if you need this
        side: BorderSide(
          color: cardcolor,
          width: 1,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: br20,
          color: cardcolor,
        ),
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0) + syh20*2,
          child: Column(
            children: [
              Row(children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    backgroundImage: NetworkImage(image), //NetworkImage
                    radius: 50,
                  ), //CircleAvatar
                ),
                SizedBox(width: 20,),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70,
                  child: Text(number,style: const TextStyle(fontSize: 50),),//CircleAvatar
                ),

              ],),
              Text(category,style: const TextStyle(fontSize: 30),),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getUser() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection('User').get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    Get.log(_myDocCount.length.toString());
    return _myDocCount.length.toString();
  }

}
