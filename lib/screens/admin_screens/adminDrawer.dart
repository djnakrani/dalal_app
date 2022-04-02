import 'package:dalal_app/screens/admin_screens/dashboard.dart';
import 'package:dalal_app/screens/admin_screens/helpline_no.dart';
import 'package:dalal_app/screens/admin_screens/youtube_link.dart';
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
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Admin"),
            accountEmail: Text("admin@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: Icon(Icons.person,size: 50,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_pin),
            title: const Text('Dashboard'),
            onTap: () {
              Get.to(() => AdminDashboard());
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: const Text('Add Youtube Link'),
            onTap: () {
              Get.to(() => const InputYTLink());
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Add Helpline Number'),
            onTap: () {
              Get.to(()=> const HelpLineno());
            },
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: const Text('Logout'),
            onTap: () {
              Get.to(() => LogOut());
            },
          ),
        ],
      ),
    );
  }
}
