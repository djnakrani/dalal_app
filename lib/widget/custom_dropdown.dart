// import 'package:flutter/material.dart';
// import 'package:dalal_app/constants/myColors.dart';
// import 'package:dalal_app/constants/style.dart';
//
// List<DropdownMenuItem<String>> get dropdownItems{
//   List<DropdownMenuItem<String>> menuItems = [
//     DropdownMenuItem(child: Text("USA"),value: "USA"),
//     DropdownMenuItem(child: Text("Canada"),value: "Canada"),
//     DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
//     DropdownMenuItem(child: Text("England"),value: "England"),
//   ];
//   return menuItems;
// }
//
// class CustomDropDown extends StatelessWidget {
//   final String hintText;
//   final String currentSelected;
//   final List<String> dropDownList;
//   final Function(String?) voidCallBack;
//
//   const CustomDropDown({
//     Key? key,
//     required this.currentSelected,
//     required this.dropDownList,
//     required this.hintText,
//     required this.voidCallBack,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // decoration: boxDecoration,
//       // height: dropdownHeight,
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton2<String>(
//           hint: Padding(
//             padding: p / 2,
//             child: Text(
//               hintText,
//               style: Styles.text18TB!.copyWith(fontWeight: FontWeight.normal),
//             ),
//           ),
//           buttonHeight: double.infinity,
//           buttonPadding: EdgeInsets.only(right: 10.h),
//           dropdownPadding: EdgeInsets.symmetric(vertical: 12.h),
//           value: currentSelected,
//           isDense: true,
//           isExpanded: true,
//           dropdownMaxHeight: 250.h,
//           scrollbarAlwaysShow: true,
//           itemHeight: 20.h,
//           scrollbarRadius: r50,
//           scrollbarThickness: 6.w,
//           buttonElevation: 0,
//           dropdownElevation: 1,
//           itemPadding: EdgeInsets.zero,
//           style: Styles.text18TB!
//               .copyWith(fontWeight: FontWeight.normal, color: Colors.black),
//           dropdownDecoration: BoxDecoration(
//             borderRadius:
//             BorderRadius.only(bottomLeft: r10 / 2, bottomRight: r10 / 2),
//             color: Colors.white,
//           ),
//           onChanged: (newValue) {
//             voidCallBack(newValue);
//           },
//           icon: SvgPicture.asset(
//             Images.iconArrowDown,
//             height: 28.h,
//             width: 28.h,
//           ),
//           items: _addDividersAfterItems(dropDownList),
//         ),
//       ),
//     );
//   }
//
//   List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
//     List<DropdownMenuItem<String>> _menuItems = [];
//     for (var item in dropDownList) {
//       _menuItems.addAll(
//         [
//           DropdownMenuItem<String>(
//             value: item,
//             child: Padding(
//               padding: symetricH30 / 2,
//               child: Text(
//                 item,
//                 style: item != currentSelected || item.contains("Select")
//                     ? Styles.text18TB!.copyWith(fontWeight: FontWeight.normal)
//                     : Styles.text18TB!.copyWith(
//                     fontWeight: FontWeight.normal, color: Colors.black),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//           if (item != items.last)
//             const DropdownMenuItem<String>(
//               enabled: false,
//               child: Divider(
//                 thickness: 1.3,
//               ),
//             ),
//         ],
//       );
//     }
//     return _menuItems;
//   }
// }