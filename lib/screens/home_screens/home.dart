import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/screens/Input_screens/take_screen.dart';
import 'package:dalal_app/screens/filter_screens/searchscreen.dart';
import 'package:dalal_app/screens/home_screens/DetailScreen.dart';
import 'package:dalal_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/constants/string.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../mydrawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(string.appName),
        backgroundColor: myColors.colorPrimaryColor,
        actions: [IconButton(onPressed: () => Get.to(()=>SearchScreen()) , icon: Icon(Icons.search))],
      ),
      drawer: const MyDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Items').snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.data == null){
                return const Center(child: CircularProgressIndicator());
              }
              else{
                return ListView.builder(
                    itemCount: snapshot.data?.size,
                    padding: ob50,
                    itemBuilder: (context, index) {

                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return MyCard(ds, context);
                    });
              }

            },
          )),
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
          builder: (BuildContext context) => const TakeScreen(),
        );
      },
      isExtended: true,
      icon: const Icon(
        Icons.add,
        size: 40,
      ),
      label: BoldText("પોસ્ટ કરો"),
    ),
  );
}

Widget MyCard(DocumentSnapshot ds, BuildContext context) {
  return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
          onTap: () async {
            await showDialog(
              builder: (BuildContext context) => DetailScreen(ds),
              context: context,
            );
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
                            Row(
                              children: [
                                BoldText("વેચનાર નું નામ: "),
                                SimpleText(ds["Seller_Name"])
                              ],
                            ),
                            Row(
                              children: [
                                BoldText("નામ: "),
                                SimpleText(ds["Item"])
                              ],
                            ),
                            Row(
                              children: [
                                BoldText("ગામ: "),
                                SimpleText(ds["Address"])
                              ],
                            ),
                            Row(
                              children: [
                                BoldText("મોબાઈલ નંબર: "),
                                SimpleText(ds["MobileNo"])
                              ],
                            ),
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
                                    launch('tel: ${ds["MobileNo"]}');
                                  },
                                  child: const Icon(Icons.call)),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: myColors.colorPrimaryColor,
                                  ),
                                  onPressed: () {
                                    launch(
                                        'https://wa.me/${ds["MobileNo"]}?text=${ds["Item"]}');
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
