import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/screens/filter_screens/searchscreen.dart';
import 'package:dalal_app/screens/home_screens/DetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/constants/string.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../mydrawer.dart';

class FilterScreen extends StatefulWidget {
  var items;
  var area;
  FilterScreen({Key? key, required this.items, this.area}) : super(key: key);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(string.appName),
        backgroundColor: myColors.colorPrimaryColor,
        actions: [
          IconButton(
              onPressed: () => Get.off(() => const SearchScreen()),
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: const MyDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Items')
                .where("Category", isEqualTo: widget.items)
                .snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              // Get.log(widget.area);
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data?.size == 0) {
                  return const Center(child: Text("No More Data Available"));
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data?.size,
                      padding: ob50,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        if (ds["City"].toString().contains(widget.area) || widget.area == "" || ds["Address"].toString().contains(widget.area) || ds["State"].toString().contains(widget.area)) {
                          return myCard(ds, context);
                        }
                        else{
                          return const SizedBox();
                        }
                      });
                }
              }
            },
          )),
    );
  }
}

Widget myCard(DocumentSnapshot ds, BuildContext context) {
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
                            customDetails("પશુ / વસ્તુ: ", ds["Item"]),
                            customDetails("વેચનાર નું નામ: ", ds["Seller_Name"]),
                            customDetails("કિંમત: ", ds["Price"]),
                            customDetails("મોબાઇલ નંબર: ", ds["MobileNo"]),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 10),
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
                                        'https://wa.me/+91${ds["MobileNo"]}?text=${ds["Item"]}');
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

