import 'package:dalal_app/constants/imports.dart';
import 'package:dalal_app/widget/custom_detailpopup.dart';

class MyPost extends StatefulWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  _MyPostState createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  String? uid;

  @override
  void initState() {
    super.initState();
    setState(() {
      uid = FirebaseAuth.instance.currentUser!.uid;
    });
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
              onPressed: () => Get.to(() => const TakeScreen()),
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const MyDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Items')
                .where("Uid", isEqualTo: uid)
                .snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.size,
                    padding: ob50,
                    itemBuilder: (context, index) {
                      DocumentSnapshot dataSet = snapshot.data!.docs[index];
                      return myCard(dataSet);
                    });
              }
            },
          )),
    );
  }
}

Widget myCard(DocumentSnapshot dataSet) {
  return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
          onTap: () {
            Get.dialog(CustomDetailsPopup(
              dataSet: dataSet,
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
                    image: NetworkImage(dataSet["Urls"][0]),
                    width: 400,
                    fit: BoxFit.fitWidth,
                  ),
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
                                CustomText(text: dataSet["Seller_Name"]),
                                CustomText(text: dataSet["Uid"])
                              ],
                            ),
                            Row(
                              children: [
                                CustomText(
                                    fontWeight: FontWeight.bold,
                                    text: 'name'.tr + ': '),
                                CustomText(text: dataSet["Item"])
                              ],
                            ),
                            Row(
                              children: [
                                CustomText(
                                    fontWeight: FontWeight.bold,
                                    text: "address".tr + ': '),
                                CustomText(text: dataSet["Address"])
                              ],
                            ),
                          ],
                        ),
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
                                  removeData(dataSet.id);
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          )));
}

Future removeData(String docId) async {
  await FirebaseFirestore.instance
      .collection('Items')
      .doc(docId)
      .delete()
      .then((value) => {Get.off(() => const MyPost())});
}
