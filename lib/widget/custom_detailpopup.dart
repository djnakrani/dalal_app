import 'package:dalal_app/constants/imports.dart';

// ignore: must_be_immutable
class CustomDetailsPopup extends StatelessWidget {
  var imageCount = 0;
  DocumentSnapshot<Object?> dataSet;
  CustomDetailsPopup({
    Key? key,
    required this.dataSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    for (var a in dataSet["Urls"]) {
      imageCount++;
    }
    return Container(
      color: Colors.white,
      padding: syv10 + syh20,
      margin: syv40 * 2 + syh20,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: imageCount,
              options: CarouselOptions(
                aspectRatio: 1.0,
                enlargeCenterPage: true,
                autoPlay: true,
              ),
              itemBuilder: (ctx, index, realIdx) {
                return PhotoView(
                    imageProvider: NetworkImage(dataSet["Urls"][index]));
              },
            ),
            customDetails('date'.tr + ":", dataSet["Date"]),
            customDetails('producttitle'.tr + ":", dataSet["Item"]),
            customDetails(
                'seller'.tr + ' ' + 'name'.tr + ":", dataSet["Seller_Name"]),
            customDetails('price'.tr + ":", dataSet["Price"]),
            customDetails('mobileNo'.tr + ":", dataSet["MobileNo"]),
            customDetails('description'.tr + ":", dataSet["Details"]),
            customDetails('address'.tr + ":", dataSet["Address"]),
            customDetails('city'.tr + ":", dataSet["City"]),
            customDetails('taluko'.tr + ":", dataSet["Taluko"]),
            customDetails("state".tr + ":", dataSet["State"]),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: myColors.colorPrimaryColor,
                      ),
                      onPressed: () {
                        Uri myUri = Uri.parse("tel: ${dataSet["MobileNo"]}");
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
                        String data = 'share'.tr;
                        launch(
                            'https://wa.me/+91${dataSet["MobileNo"]}?text=$data');
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
                        share(dataSet);
                      },
                      child: const Icon(Icons.share)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

void share(DocumentSnapshot<Object?> ds) async {
  String data = "Seller Name:" +ds["Seller_Name"]+
      "\nMobile Number:" +ds["MobileNo"]+
      "\nProduct:" +ds["Item"]+
      "\nAddress:" +ds["Address"]+
      "\nDetails:" +ds["Details"]+
      "\nDownload App For More Details:https://play.google.com/store/apps/details?id=com.rudra.dalal_app";
  await Share.share(
    data,
    subject: 'producttitle'.tr + ds["Item"],
  );
}

customDetails(title, value) {
  return Padding(
    padding: syv10,
    child: Row(
      children: [
        CustomText(fontWeight: FontWeight.bold, text: title),
        const SizedBox(width: 5.0),
        Flexible(child: CustomText(text: value)),
      ],
    ),
  );
}
