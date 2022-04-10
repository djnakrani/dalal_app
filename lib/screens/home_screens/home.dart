import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/screens/Input_screens/take_screen.dart';
import 'package:dalal_app/screens/admin_screens/dashboard.dart';
import 'package:dalal_app/screens/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/constants/string.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../mydrawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  List<String> pname = ["ગાય ", "ભેંસ"];
  List<String> mno = ["9067127486", "7096750532"];
  List<String> loc = ["Surat", "Bhanvnahar"];
  List<String> cname = ["Dharmik", "Manhar"];
  List<String> photo = ["assets/images/photo1.png", "assets/images/photo2.png"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(string.appName),
        backgroundColor: myColors.colorPrimaryColor,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child:
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Items').snapshots(),
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
                  //     photo[index],context);

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
                    image: AssetImage(Images.logoImage),
                    width: 400,
                    fit: BoxFit.fitWidth,
                  ),
                  Positioned(
                      top: 2,
                      right: 5,
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ))
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
                              alignment: Alignment.topRight,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: myColors.colorPrimaryColor,
                                  ),
                                  onPressed: () {
                                    launch('tel: +91${ds["MobileNo"]}');
                                  },
                                  child: Icon(Icons.call)),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: myColors.colorPrimaryColor,
                                  ),
                                  onPressed: () {
                                    launch('https://wa.me/+91${ds["MobileNo"]}?text=${ds["Item"]}');
                                  },
                                  child: Ink.image(
                                      height: 30,
                                      width: 30,
                                      image: const AssetImage(Images.wsLogo))),
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
