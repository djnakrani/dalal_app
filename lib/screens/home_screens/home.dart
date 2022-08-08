import 'package:dalal_app/constants/imports.dart';
import 'package:dalal_app/screens/filter_screens/searchscreen.dart';

import 'cardView.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: MyString.appName,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            size: 16.0),
        backgroundColor: myColors.colorPrimaryColor,
        actions: [
          IconButton(
              onPressed: () => Get.to(() => const SearchScreen()),
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: const MyDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Items').snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.size,
                    padding: ob50,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return myCard(ds, context);
                    });
              }
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: bottomBar(context),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Padding(
      padding: ah10,
      child: FloatingActionButton.extended(
        backgroundColor: myColors.colorPrimaryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const TakeScreen(),
          );
        },
        isExtended: true,
        icon: const Icon(
          Icons.add,
          size: 40,
        ),
        label: CustomText(
          fontWeight: FontWeight.bold,
          text: 'postadd'.tr,
          // text: translatorString("Add Post"),
          color: Colors.white,
        ),
      ),
    );
  }
}

Widget myCard(DocumentSnapshot ds, BuildContext context) {
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
                          alertShow("Add In Favorite", Icons.check,
                              "Check Your Favorite Box");
                          add(ds);
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
                                    text:
                                    'seller'.tr + ' ' + 'name'.tr + ': '),
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
                                        Uri myUri = Uri.parse(
                                            "tel: ${ds["MobileNo"]}");
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
                                            'share'.tr;
                                        launch(
                                            'https://wa.me/+${ds["MobileNo"]}?text=$data');
                                      },
                                      child: Ink.image(
                                          height: 30,
                                          width: 30,
                                          image: const AssetImage(
                                              Images.wsLogo))),
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

void add(DocumentSnapshot<Object?> ds) {
  FirebaseFirestore.instance.collection('Favorite').doc(uid).update({
    "Items": FieldValue.arrayUnion([ds.id.toString()])
  }).onError((error, stackTrace) {
    FirebaseFirestore.instance.collection('Favorite').doc(uid).set({
      "Items": [ds.id.toString()]
    });
  });
}
