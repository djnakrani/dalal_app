import 'package:dalal_app/constants/imports.dart';

logOut() async {
  await FirebaseAuth.instance.signOut();
  if (FirebaseAuth.instance.currentUser == null) {
    alertShow("Logout", Icons.logout, "Successfully Logout Your Account");
    Get.offAll(() => const Login());
  }
  return null;

}