import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/screens/home_screens/cardView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/constants/string.dart';
import 'package:get/get.dart';

import '../mydrawer.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  var favItems = [];

  @override
  void initState() {
    super.initState();
    favItems.clear();
    FirebaseFirestore.instance
        .collection('Favorite')
        .doc(uid)
        .get()
        .then((value) {
      var snapshotdata = value.data() as Map;
      for (var a in snapshotdata["Items"]) {
        if (favItems.contains(a)) {
        } else {
          setState(() {
            favItems.add(a);
          });
        }
      }
      Get.log(favItems.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(string.appName),
        backgroundColor: myColors.colorPrimaryColor,
      ),
      drawer: const MyDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Items').snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: favItems.length,
                    padding: ob50,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      if (favItems.contains(ds.id)) {
                        return cardView(ds, context);
                      } else {
                        return SizedBox();
                      }
                    });
              }
            },
          )),
    );
  }
}
