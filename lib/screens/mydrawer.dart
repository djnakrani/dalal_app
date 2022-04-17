import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/screens/Input_screens/take_screen.dart';
import 'package:dalal_app/screens/home_screens/home.dart';
import 'package:dalal_app/screens/home_screens/mypost.dart';
import 'package:dalal_app/screens/home_screens/userhelplineno.dart';
import 'package:dalal_app/screens/home_screens/youtubeview.dart';
import 'package:dalal_app/screens/login_signup_screens/logout.dart';
import 'package:dalal_app/screens/login_signup_screens/signup.dart';
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
  String? _name ="1",_mail="1";
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
        build(context);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: BoldText(_name),
            accountEmail: BoldText(_mail),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: SimpleText("Home"),
            onTap: () {
              Get.to(()=> Home());
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_pin),
            title:  SimpleText("My Profile"),
            onTap: () {
              Get.to(()=> const Signup());
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title:  SimpleText("Add Items"),
            onTap: () {
              Get.to(()=> const TakeScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_outlined),
            title:  SimpleText("My Post"),
            onTap: () {
              Get.to(()=>MyPost());
            },
          ),
          ListTile(
            leading: const Icon(Icons.play_circle_fill),
            title:  SimpleText("My Youtube"),
            onTap: () {
              Get.to(()=> YoutubeView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_ic_call_outlined),
            title:  SimpleText("Help Line No"),
            onTap: () {
              Get.to(()=>const UserHelpLine());
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title:  SimpleText("My Favroite"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title:  SimpleText("Logout"),
            onTap: () {
              Get.to(LogOut());
            },
          ),
        ],
      ),
    );
  }
}
