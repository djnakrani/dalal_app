import 'package:dalal_app/constants/imports.dart';

logOut() {
  FirebaseAuth.instance.signOut();
  if (FirebaseAuth.instance.currentUser == null) {
    AlertShow("Logout", Icons.logout, "Successfully Logout Your Account");
    Get.offAll(() => const Login());
  }
  return null;

}