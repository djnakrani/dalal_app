import 'package:dalal_app/constants/imports.dart';
import 'package:dalal_app/screens/home_screens/favorite_screen.dart';
import 'package:url_launcher/url_launcher.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;
Widget cardView(DocumentSnapshot ds, BuildContext context) {
  return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
          onTap: () async {
            Get.dialog(CustomDetailsPopup(
              dataSet: ds,
            ));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Ink.image(
                    height: 200,
                    image: NetworkImage(ds["Urls"][0]),
                    width: 400,
                    fit: BoxFit.fitWidth,
                  ),
                  Positioned(
                      top: 2,
                      right: 5,
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          remove(ds);
                          Get.to(() => const FavoriteScreen());
                          AlertShow('Success', Icons.check, 'Removed');
                        },
                      )),
                ],
              ),
              Padding(
                  padding: ah10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: ah10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                    fontWeight: FontWeight.bold,
                                    text: 'seller'.tr + ' ' + 'name'.tr + ': '),
                                CustomText(text: ds["Seller_Name"])
                              ],
                            ),
                            Row(
                              children: [
                                CustomText(
                                    fontWeight: FontWeight.bold,
                                    text: 'name'.tr + ': '),
                                CustomText(text: ds["Item"])
                              ],
                            ),
                            Row(
                              children: [
                                CustomText(
                                    fontWeight: FontWeight.bold,
                                    text: "address".tr + ': '),
                                CustomText(text: ds["Address"])
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: syh20 + ot50 / 2,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: myColors.colorPrimaryColor,
                                      ),
                                      onPressed: () {
                                        Uri myUri =
                                            Uri.parse("tel: ${ds["MobileNo"]}");
                                        launchUrl(myUri);
                                      },
                                      child: const Icon(Icons.call)),
                                ),
                                Padding(
                                  padding: syh20 + ot50 / 2,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: myColors.colorPrimaryColor,
                                      ),
                                      onPressed: () {
                                        String data =
                                            "Download App For More Details:";
                                        launch(
                                            'https://wa.me/+91${ds["MobileNo"]}?text=$data');
                                      },
                                      child: Ink.image(
                                          height: 30,
                                          width: 30,
                                          image:
                                              const AssetImage(Images.wsLogo))),
                                ),
                                Padding(
                                  padding: syh20 + ot50 / 2,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: myColors.colorPrimaryColor,
                                      ),
                                      onPressed: () {
                                        share(ds);
                                      },
                                      child: const Icon(Icons.share)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          )));
}

void remove(DocumentSnapshot<Object?> ds) {
  FirebaseFirestore.instance.collection('Favorite').doc(uid).update({
    "Items": FieldValue.arrayRemove([ds.id.toString()])
  });

  Future.delayed(Duration(seconds: 1), () {
    Get.offAll(() => FavoriteScreen());
  });
}
