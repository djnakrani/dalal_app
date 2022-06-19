import 'package:dalal_app/constants/imports.dart';

Future<dynamic>? get_user() async {
  String uid;
  if (await FirebaseAuth.instance.currentUser != null) {
    uid = FirebaseAuth.instance.currentUser!.uid;
    Get.log(uid+"Login");
    return FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .get();
  }else{
    Get.offAll(() => const Login());
    // Get.offAll(() => const LanguageSelector());
    return null;
  }
}

