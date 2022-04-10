import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/screens/Input_screens/input_form.dart';
import 'package:dalal_app/screens/home_screens/userhelplineno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/style.dart';

class TakeScreen extends StatefulWidget {
  const TakeScreen({Key? key}) : super(key: key);

  @override
  _TakeScreenState createState() => _TakeScreenState();
}

class _TakeScreenState extends State<TakeScreen> {
  List CategoryList = [];

  final Stream<QuerySnapshot> data =
      FirebaseFirestore.instance.collection("Category").snapshots();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const UserHelpLine());
                        },
                        style: ElevatedButton.styleFrom(
                            primary: myColors.colorPrimaryColor),
                        child: Row(
                          children: [
                            Image.asset(Images.logoImage,
                                height: 50.h, width: 50.w),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 5.0),
                              child: Text(
                                "ખેડૂત હેલ્પલાઈન નંબર ",
                                style: TextStyle(
                                    fontSize: 30.w, color: Colors.white),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: data,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Please Try Again...");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading....");
                      }
                      final Category = snapshot.requireData;
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: Category.size,
                        padding: const EdgeInsets.all(5),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              margin: ah10,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => InputForm(
                                      Category: Category.docs[index]['Type']));
                                },
                                style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.green,
                                    primary: Colors.white60),
                                child:
                                    Image.network(Category.docs[index]['url']),
                              ));
                        },
                      );
                    }),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      " Close ",
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
