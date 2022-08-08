import 'package:dalal_app/constants/imports.dart';

alertShow(msg, icon, desc) {
  Get.defaultDialog(
      title: msg,
      content: Row(
        children: [
          Icon(
            icon,
            color: myColors.colorPrimaryColor,
          ),
          const SizedBox(
            width: 18,
          ),
          Expanded(child: Text(desc)),
        ],
      ));
}
