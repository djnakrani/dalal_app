import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:share_plus/share_plus.dart';
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
        margin: syv40 * 4 + syh20,
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
                  return Image.network(ds["Urls"][index]);
                },
              ),
              customDetails("તારીખ: ", ds["Date"]),
              customDetails("પશુ / વસ્તુ: ", ds["Item"]),
              customDetails("વેચનાર નું નામ: ", ds["Seller_Name"]),
              customDetails("કિંમત: ", ds["Price"]),
              customDetails("મોબાઇલ નંબર: ", ds["MobileNo"]),
              customDetails("વર્ણન: ", ds["Details"]),
              customDetails("સરનામું: ", ds["Address"]),
              customDetails("જિલ્લો: ", ds["City"]),
              customDetails("રાજ્ય: ", ds["State"]),
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
                  const SizedBox(
                    width: 5.0,
                  ),
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
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: myColors.colorPrimaryColor,
                        ),
                        onPressed: () {
                          share(ds);
                        },
                        child: const Icon(Icons.share)),

                  )
                ],
              )
            ],
          ),
        ),
      ));


}

void share(DocumentSnapshot<Object?> ds) async {
  String data = "તારીખ: "+ds["Date"] +"\n પશુ / વસ્તુ: " + ds["Item"] + "\nવેચનાર નું નામ: " + ds["Seller_Name"] +
      " \nકિંમત: " + ds["Price"] + "\nમોબાઇલ નંબર: " + ds["MobileNo"] + "\nવર્ણન: " + ds["Details"] +"\nસરનામું: " + ds["Address"]
      + "\nજિલ્લો: " + ds["City"] +"\nરાજ્ય: " + ds["State"];

  await Share.share(
    data,
    subject: "પશુ / વસ્તુ: " + ds["Item"],
  );
}

customDetails(title, value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        BoldText(title),
        Flexible(child: SimpleText(value)),
      ],
    ),
  );
}
