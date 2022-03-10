import 'package:dalal_app/screens/Input_screen/take_screen.dart';
import 'package:dalal_app/screens/login_signup/logout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class mydrawer extends StatefulWidget {
  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<mydrawer> {
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
              child: Text(
                "DN",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: const Text('My Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            title: const Text('Add My Items'),
            onTap: () {
              Get.to(TakeScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: const Text('My Favourite'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
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
