import 'package:dalal_app/constants/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final lang = GetStorage();
  @override
  void initState() {
    super.initState();
    _selectlang();
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
          height: Get.size.height,
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
    }).onError((error, stackTrace) {
      Get.log(error.toString());
      Get.offAll(() => const LanguageSelector());
      // Get.offAll(() => const Signup());
    });
  }

  void _selectlang() {
    var locale;
    if (lang.read('mylang') == "Gujarati"){
      locale = Locale('gu','IN');
    }
    else if(lang.read('mylang') == "Hindi"){
      locale = Locale('hi','IN');
    }
    else{
      locale = Locale('en','US');
    }
    Get.updateLocale(locale);
  }
}
