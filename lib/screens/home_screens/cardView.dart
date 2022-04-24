import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/error.dart';
import 'package:dalal_app/screens/home_screens/DetailScreen.dart';
import 'package:dalal_app/widget/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dalal_app/constants/myColors.dart';


import '../../constants/Images.dart';
import 'favorite_screen.dart';
String uid = FirebaseAuth.instance.currentUser!.uid;
Widget cardView(DocumentSnapshot ds, BuildContext context) {

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
                          Icons.close_rounded,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => ErrorScreen(
                              error: 'Removed',
                            ),
                          );
                          remove(ds);
                        },
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
                                      image:
                                      AssetImage(Images.wsLogo))),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          )));
}

void remove(DocumentSnapshot<Object?> ds) {
  FirebaseFirestore.instance.collection('Favorite').doc(uid).update({
    "Items": FieldValue.arrayRemove([ds.id.toString()])
  });
}

