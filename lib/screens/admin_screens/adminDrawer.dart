import 'package:dalal_app/screens/login_signup_screens/logout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Admin"),
            accountEmail: Text("admin@gmail.com"),
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
              // Get.to(Signup());
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: const Text('Add My Items'),
            onTap: () {
              // Get.to(TakeScreen());
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
