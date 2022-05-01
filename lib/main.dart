import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/screens/login_signup_screens/login.dart';
import 'package:dalal_app/screens/login_signup_screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        builder: (context) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'દલાલ',
          theme: ThemeData(
            primaryColor: myColors.colorPrimaryColor,
          ),
          home: SplashScreen(),
          // home: Login(),
        ),
      designSize: const Size(392,850),
    );
  }
}