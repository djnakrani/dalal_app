import 'package:dalal_app/constants/imports.dart';
import 'package:dalal_app/screens/home_screens/UserDetails.dart';
import 'package:dalal_app/screens/home_screens/favorite_screen.dart';
import 'package:dalal_app/screens/home_screens/mypost.dart';
import 'package:dalal_app/screens/home_screens/userhelplineno.dart';
import 'package:dalal_app/screens/home_screens/youtubeview.dart';
import 'package:dalal_app/screens/login_signup_screens/logout.dart';

import 'admin_screens/allpost.dart';
import 'admin_screens/helpline_no.dart';
import 'admin_screens/youtube_link.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<MyDrawer> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  final user_name_email = GetStorage();
  var name = "";
  var email = "";
  @override
  void initState() {
    name = user_name_email.read('userName') ?? "";
    email = user_name_email.read('userEmail') ?? "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Center(
            child: UserAccountsDrawerHeader(
              accountName: boldText(name),
              accountEmail: boldText(email),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: Icon(Icons.person),
              ),
              currentAccountPictureSize: const Size(80,80),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: SimpleText('home'.tr),
            onTap: () {
              Get.to(()=> const Home());
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_pin),
            title:  SimpleText('mydetails'.tr),
            onTap: () {
              Get.to(()=> const UserDetails());
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title:  SimpleText('postadd'.tr),
            onTap: () {
              Get.to(()=> const TakeScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_outlined),
            title:  SimpleText('mypost'.tr),
            onTap: () {
              Get.to(()=>const MyPost());
            },
          ),
          ListTile(
            leading: const Icon(Icons.play_circle_fill),
            title:  SimpleText('tv'.tr),
            onTap: () {
              Get.to(()=> const YoutubeView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_ic_call_outlined),
            title:  SimpleText('helpline'.tr),
            onTap: () {
              Get.to(()=>const UserHelpLine());
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title:  SimpleText('favorite'.tr),
            onTap: () {
              Get.offAll(() => const FavoriteScreen());

            },
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title:  SimpleText('logout'.tr),
            onTap: () {
              logOut();
            },
          ),
        ],
      ),
    );
  }
}


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
          Center(
            child: UserAccountsDrawerHeader(
              accountName: boldText("Admin"),
              accountEmail: const Text(""),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: Icon(Icons.person,size: 50,),
              ),
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
            leading: const Icon(Icons.list_alt),
            title: SimpleText('All Post'),
            onTap: () {
              Get.to(() => AllPost());
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
              Get.to(() => logOut());
            },
          ),
        ],
      ),
    );
  }
}
