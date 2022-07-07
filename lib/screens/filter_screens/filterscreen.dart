import 'package:dalal_app/screens/filter_screens/searchscreen.dart';
import 'package:dalal_app/constants/imports.dart';
import 'package:dalal_app/screens/home_screens/cardView.dart';

class FilterScreen extends StatefulWidget {
  var items;
  var area;
  FilterScreen({Key? key, required this.items, this.area}) : super(key: key);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    super.initState();
    // Get.log(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: 'appTitle'.tr,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            size: 18.0),
        backgroundColor: myColors.colorPrimaryColor,
        actions: [
          IconButton(
              onPressed: () => Get.off(() => const SearchScreen()),
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: const MyDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Items')
                .where("Category", isEqualTo: widget.items)
                .snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.size,
                    padding: ob50,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      // return myCard(ds, context);
                      if (widget.area == "" ||
                          ds["City"].toString().contains(widget.area) ||
                          ds["Address"].toString().contains(widget.area) ||
                          ds["State"].toString().contains(widget.area) ||
                          ds["Taluka"].toString().contains(widget.area)) {
                        return myCard(ds, context);
                      } else {
                        return const SizedBox();
                      }
                    });
              }
            },
          )),
    );
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
                            AlertShow(
                                "Success", Icons.favorite, 'Added To Favorite');
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
                                      text: 'seller'.tr + ' ' + 'name'.tr),
                                  CustomText(text: ds["Seller_Name"])
                                ],
                              ),
                              Row(
                                children: [
                                  CustomText(
                                      fontWeight: FontWeight.bold,
                                      text: 'name'.tr),
                                  CustomText(text: ds["Item"])
                                ],
                              ),
                              Row(
                                children: [
                                  CustomText(
                                      fontWeight: FontWeight.bold,
                                      text: "address".tr),
                                  CustomText(text: ds["Address"])
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
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
                              Align(
                                alignment: Alignment.centerRight,
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
                                        image:
                                            const AssetImage(Images.wsLogo))),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
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
                        )
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
      subject: "પશુ / વસ્તુ: " + ds["Item"],
    );
  }
}
