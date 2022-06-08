import 'package:dalal_app/constants/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.splash), fit: BoxFit.contain)),
          height: MediaQuery.of(context).size.height,
        ));
  }

  void _navigatePage() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    get_user()!.then((value) {
      if (value["IsAdmin"] == "1") {
        Get.offAll(() => const AdminDashboard());
      } else if (value["IsAdmin"] == "0") {
        Get.offAll(() => const Home());
      }
    }).onError((error, stackTrace) => Get.offAll(() => const Signup()));
  }
}
