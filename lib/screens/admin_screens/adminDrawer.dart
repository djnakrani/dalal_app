import 'package:dalal_app/screens/admin_screens/dashboard.dart';
import 'package:dalal_app/screens/admin_screens/helpline_no.dart';
import 'package:dalal_app/screens/admin_screens/youtube_link.dart';
import 'package:dalal_app/screens/login_signup_screens/logout.dart';
import 'package:dalal_app/widget/custom_text.dart';
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
          UserAccountsDrawerHeader(
            accountName: BoldText("Admin"),
            accountEmail: Text(""),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: Icon(Icons.person,size: 50,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_pin),
            title: SimpleText('Dashboard'),
            onTap: () {
              Get.to(() => AdminDashboard());
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: SimpleText('Add Youtube Link'),
            onTap: () {
              Get.to(() => const InputYTLink());
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: SimpleText('Add Helpline Number'),
            onTap: () {
              Get.to(()=> const HelpLineno());
            },
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: SimpleText('Logout'),
            onTap: () {
              Get.to(() => const LogOut());
            },
          ),
        ],
      ),
    );
  }
}
