import 'package:dalal_app/constants/imports.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:photo_view/photo_view.dart';
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
        margin: syv40 * 2 + syh20,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider.builder(
                itemCount: count,
                options: CarouselOptions(
                  aspectRatio: 1.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                itemBuilder: (ctx, index, realIdx) {
                  return PhotoView(
                      imageProvider: NetworkImage(ds["Urls"][index]));
                },
              ),
              customDetails('date'.tr + ":", ds["Date"]),
              customDetails('producttitle'.tr + ":", ds["Item"]),
              customDetails(
                  'seller'.tr + ' ' + 'name'.tr + ":", ds["Seller_Name"]),
              customDetails('price'.tr + ":", ds["Price"]),
              customDetails('mobileNo'.tr + ":", ds["MobileNo"]),
              customDetails('description'.tr + ":", ds["Details"]),
              customDetails('address'.tr + ":", ds["Address"]),
              customDetails('city'.tr + ":", ds["City"]),
              customDetails('taluko'.tr + ":", ds["Taluka"]),
              customDetails("state".tr + ":", ds["State"]),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: myColors.colorPrimaryColor,
                        ),
                        onPressed: () {
                          Uri myUri = Uri.parse("tel: ${ds["MobileNo"]}");
                          launchUrl(myUri);
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
                          String data = "તારીખ: " +
                              ds["Date"] +
                              "\n પશુ / વસ્તુ: " +
                              ds["Item"] +
                              "\nવેચનાર નું નામ: " +
                              ds["Seller_Name"] +
                              " \nકિંમત: " +
                              ds["Price"] +
                              "\nમોબાઇલ નંબર: " +
                              ds["MobileNo"] +
                              "\nવર્ણન: " +
                              ds["Details"] +
                              "\nસરનામું: " +
                              ds["Address"] +
                              "\nજિલ્લો: " +
                              ds["City"] +
                              "\nરાજ્ય: " +
                              ds["State"];
                          Uri myUri = Uri.parse(
                              'https://wa.me/${ds["MobileNo"]}?text=$data');
                          launchUrl(myUri);
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
  String data = "તારીખ: " +
      ds["Date"] +
      "\n પશુ / વસ્તુ: " +
      ds["Item"] +
      "\nવેચનાર નું નામ: " +
      ds["Seller_Name"] +
      " \nકિંમત: " +
      ds["Price"] +
      "\nમોબાઇલ નંબર: " +
      ds["MobileNo"] +
      "\nવર્ણન: " +
      ds["Details"] +
      "\nસરનામું: " +
      ds["Address"] +
      "\nજિલ્લો: " +
      ds["City"] +
      "\nરાજ્ય: " +
      ds["State"];

  await Share.share(
    data,
    subject: 'producttitle'.tr + ds["Item"],
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
