import 'package:dalal_app/constants/imports.dart';

dataTableTitle(String s) {
  return Expanded(
      child: Container(
    height: 30.0,
    decoration: BoxDecoration(
      borderRadius: br20,
      color: myColors.colorPrimaryColor,
    ),
    child: Center(
      child: CustomText(text: s, color: Colors.white),
    ),
  ));
}
