import 'package:dalal_app/constants/imports.dart';

AlertShow(msg,icon,desc){
  Get.defaultDialog(
    title: msg,
    content: Row(
      children: [
        Icon(
          icon,
          color: myColors.colorPrimaryColor,
        ),
        SizedBox(
          width: 18,
        ),
        Expanded(
          child:Text(desc)
        ),
      ],
    )
  );
}