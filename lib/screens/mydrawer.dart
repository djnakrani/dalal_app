import 'package:dalal_app/screens/Input_screens/take_screen.dart';
import 'package:dalal_app/screens/login_signup_screens/logout.dart';
import 'package:dalal_app/screens/login_signup_screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Dharmik Nakrani"),
            accountEmail: Text("dharmik.nakrani@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_pin),
            title: const Text('My Profile'),
            onTap: () {
              Get.to(()=>Signup());
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: const Text('Add My Items'),
            onTap: () {
              Get.to(()=>TakeScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('My Favourite'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: const Text('Logout'),
            onTap: () {
              Get.to(LogOut());
            },
          ),
        ],
      ),
    );
  }
}
