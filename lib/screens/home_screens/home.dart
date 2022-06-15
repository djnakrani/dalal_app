import 'package:dalal_app/constants/imports.dart';
import 'package:dalal_app/screens/filter_screens/searchscreen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SimpleText('appTitle'.tr),
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
      padding: const EdgeInsets.all(8.0),
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
        label: BoldText('postadd'.tr),
      ),
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
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            AlertShow("Add In Favorite",Icons.check,"Check Your Favorite Box");
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
                                  BoldText('seller'.tr + ' ' + 'name'.tr),
                                  SimpleText(ds["Seller_Name"])
                                ],
                              ),
                              Row(
                                children: [
                                  BoldText('name'.tr),
                                  SimpleText(ds["Item"])
                                ],
                              ),
                              Row(
                                children: [
                                  BoldText("address".tr),
                                  SimpleText(ds["Address"])
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: syh20 + ot50/2,
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
                                  Padding(
                                    padding: syh20 + ot50/2,
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
                                  ),
                                  Padding(
                                    padding: syh20 + ot50/2,
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
}
