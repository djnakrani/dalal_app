import 'package:dalal_app/constants/imports.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ScreenUtilInit(
        builder: (_,child) => GetMaterialApp(
          translations: LocateString(),
          locale: const Locale('en','US'),
          debugShowCheckedModeBanner: false,
          title: 'appTitle'.tr,
          theme: ThemeData(
            primaryColor: myColors.colorPrimaryColor,
          ),
          home: const SplashScreen(),
          // home: Login(),
        ),
      designSize: const Size(392,850),
    );
  }
}