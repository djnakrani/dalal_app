import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/Images.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

Widget DetailScreen(ds) {
  var count = 0;
  for (var a in ds["Urls"]) {
    count++;
  }
  return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: ah10,
      child: Container(
        color: Colors.white,
        padding: syv10 + syh20,
        margin: syv40*4 + syh20,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider.builder(
                itemCount: count,
                options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                itemBuilder: (ctx, index, realIdx) {
                  return Container(
                    child: Image.network(ds["Urls"][index]),
                  );
                },
              ),
              CustomDetails("પશુ / વસ્તુ: ", ds["Item"]),
              CustomDetails("વેચનાર નું નામ: ", ds["Seller_Name"]),
              CustomDetails("કિંમત: ", ds["Price"]),
              CustomDetails("મોબાઇલ નંબર: ", ds["MobileNo"]),
              CustomDetails("વર્ણન: ", ds["Details"]),
              CustomDetails("સરનામું: ", ds["Address"]),
              CustomDetails("જિલ્લો: ", ds["City"]),
              CustomDetails("રાજ્ય: ", ds["State"]),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: myColors.colorPrimaryColor,
                        ),
                        onPressed: () {
                          launch('tel:${ds["MobileNo"]}');
                        },
                        child: const Icon(Icons.call)),
                  ),
                  SizedBox(width: 5.0,),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: myColors.colorPrimaryColor,
                        ),
                        onPressed: () {
                          launch(
                              'https://wa.me/+${ds["MobileNo"]}?text=${ds["Item"]}');
                        },
                        child: Ink.image(
                            height: 30,
                            width: 30,
                            image: const AssetImage(Images.wsLogo))),
                  )
                ],
              )
            ],
          ),
        ),
      ));
}

CustomDetails(title,value){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        BoldText(title),
        SimpleText(value),
      ],
    ),
  );
}