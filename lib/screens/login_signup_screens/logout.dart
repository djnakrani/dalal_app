import 'package:dalal_app/constants/imports.dart';

Widget? logOut() {
  FirebaseAuth.instance.signOut();
  if (FirebaseAuth.instance.currentUser == null) {
    Get.offAll(() => const Login());
  }
  return null;
  // else {
  //   return MessageBox(msg: 'Sorry Please Try Again', icon: Icons.error,);
  // }
}