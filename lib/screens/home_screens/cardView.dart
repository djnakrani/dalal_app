import 'package:dalal_app/constants/imports.dart';
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
            await showDialog(
              builder: (BuildContext context) => DetailScreen(ds),
              context: context,
            );
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
                          Icons.close_rounded,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          AlertShow('Success', Icons.check,'Removed');
                          remove(ds);
                        },
                      ))
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
                            customDetails('producttitle'.tr, ds["Item"]),
                            customDetails('seller'.tr + ' ' + 'name'.tr, ds["Seller_Name"]),
                            customDetails('price'.tr, ds["Price"]),
                            // customDetails('mobileNo'.tr, ds["MobileNo"]),
                            customDetails('date'.tr, ds["Date"]),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: myColors.colorPrimaryColor,
                                  ),
                                  onPressed: () {
                                    String data = "તારીખ: "+ds["Date"] +"\n પશુ / વસ્તુ: " + ds["Item"] + "\nવેચનાર નું નામ: " + ds["Seller_Name"] +
                                        " \nકિંમત: " + ds["Price"] + "\nમોબાઇલ નંબર: " + ds["MobileNo"] + "\nવર્ણન: " + ds["Details"] +"\nસરનામું: " + ds["Address"]
                                        + "\nજિલ્લો: " + ds["City"] +"\nરાજ્ય: " + ds["State"];
                                    Uri myUri = Uri.parse('https://wa.me/${ds["MobileNo"]}?text=$data');
                                    launchUrl(myUri);
                                  },
                                  child: Ink.image(
                                      height: 30,
                                      width: 30,
                                      image:
                                      const AssetImage(Images.wsLogo))),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          )));
}

void remove(DocumentSnapshot<Object?> ds) {
  FirebaseFirestore.instance.collection('Favorite').doc(uid).update({
    "Items": FieldValue.arrayRemove([ds.id.toString()])
  });
}

