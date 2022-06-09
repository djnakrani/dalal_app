import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/screens/Input_screens/take_screen.dart';
import 'package:dalal_app/screens/home_screens/UserDetails.dart';
import 'package:dalal_app/screens/home_screens/favorite_screen.dart';
import 'package:dalal_app/screens/home_screens/home.dart';
import 'package:dalal_app/screens/home_screens/mypost.dart';
import 'package:dalal_app/screens/home_screens/userhelplineno.dart';
import 'package:dalal_app/screens/home_screens/youtubeview.dart';
import 'package:dalal_app/screens/login_signup_screens/logout.dart';
import 'package:dalal_app/widget/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<MyDrawer> {
  String? _name ="User",_mail="User@mail.com";
  var uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(()  {
      FirebaseFirestore.instance.collection('User').doc(uid).get().then((value) {
        Get.log(value["Name"]);
        Get.log(value["Email"]);
        _name = value["Name"];
        _mail = value["Email"];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Center(
            child: UserAccountsDrawerHeader(
              accountName: BoldText(""),
              accountEmail: BoldText(""),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: Icon(Icons.person),
              ),
              currentAccountPictureSize: Size(80,80),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: SimpleText("હોમ"),
            onTap: () {
              Get.to(()=> const Home());
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_pin),
            title:  SimpleText("મારી વિગતો"),
            onTap: () {
              Get.to(()=> const UserDetails());
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title:  SimpleText("પોસ્ટ ઉમેરો"),
            onTap: () {
              Get.to(()=> const TakeScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_outlined),
            title:  SimpleText("મારી પોસ્ટ"),
            onTap: () {
              Get.to(()=>const MyPost());
            },
          ),
          ListTile(
            leading: const Icon(Icons.play_circle_fill),
            title:  SimpleText("કિસાન ટીવી"),
            onTap: () {
              Get.to(()=> const YoutubeView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_ic_call_outlined),
            title:  SimpleText("હેલ્પલાઈન નંબર"),
            onTap: () {
              Get.to(()=>const UserHelpLine());
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title:  SimpleText("મને ગમતું"),
            onTap: () {
              Get.offAll(() => const FavoriteScreen());

            },
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title:  SimpleText("લોગ આઉટ"),
            onTap: () {
              logOut();
            },
          ),
        ],
      ),
    );
  }
}
