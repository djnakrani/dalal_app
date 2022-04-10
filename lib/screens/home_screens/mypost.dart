import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/screens/Input_screens/take_screen.dart';
import 'package:dalal_app/screens/admin_screens/dashboard.dart';
import 'package:dalal_app/screens/error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/constants/string.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../mydrawer.dart';

class MyPost extends StatefulWidget {
  @override
  _MyPostState createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(string.appName + "- MY POST "),
        backgroundColor: myColors.colorPrimaryColor,
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child:
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Items').where("Uid",isEqualTo: uid).snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            Get.log(snapshot.data!.size.toString());
            return ListView.builder(
                  itemCount: snapshot.data!.size,
                  padding: ob50,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    Get.log(ds["Address"]);
                    return MyCard(ds,context);
                  }
                  );
          },
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: bottonbar(context),
    );
  }
}

Widget bottonbar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FloatingActionButton.extended(
      backgroundColor: myColors.colorPrimaryColor,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => TakeScreen(),
        );
      },
      isExtended: true,
      icon: Icon(Icons.add),
      label: Text("પોસ્ટ કરો"),
    ),
  );
}

Widget MyCard(DocumentSnapshot ds,BuildContext context) {
  return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
          onTap: () async {
                Get.log("Hello");
                await showDialog(
                  builder: (BuildContext context) => DetailScreen(),
                  context: context,
                );
                // TakeScreen();
              },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Ink.image(
                    height: 200,
                    image: NetworkImage(ds["Urls"][0]),
                    width: 400,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
              Padding(
                  padding: ah10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: ah10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("વેચનાર નું નામ : ${ds["Seller_Name"]}"),
                            Text(
                              "પ્રાણી : ${ds["Item"]}",
                            ),
                            Text(
                              "ગામ : ${ds["Address"]}",
                            ),
                            Text(
                              "મોબાઈલ નંબર  : ${ds["MobileNo"]}",
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: myColors.btnRemove,
                                  ),
                                  onPressed: () {
                                  },
                                  child: const Icon(Icons.delete)),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          )));
}

 Widget DetailScreen()  {
  return AlertDialog(
    title: Text("Hello"),
  );
}
