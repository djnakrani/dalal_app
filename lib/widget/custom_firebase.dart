import 'package:dalal_app/constants/imports.dart';

Future<dynamic>? get_user(){
  String uid;
  if (FirebaseAuth.instance.currentUser != null) {
    uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .get();
  }else{
    Get.offAll(() => const Login());
    return null;
  }
}

