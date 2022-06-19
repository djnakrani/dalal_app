import 'package:dalal_app/constants/imports.dart';

class MyPost extends StatefulWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  _MyPostState createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  String? uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      uid = FirebaseAuth.instance.currentUser!.uid;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SimpleText('appTitle'.tr),
        backgroundColor: myColors.colorPrimaryColor,
        actions: [IconButton(onPressed: () => Get.to(()=>const TakeScreen()), icon: const Icon(Icons.add))],
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child:
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Items').where("Uid",isEqualTo: uid).snapshots(),
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
        )
      ),
    );
  }
}

Widget myCard(DocumentSnapshot ds,BuildContext context) {
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
                            // customDetails('producttitle'.tr + ': ', ds["Item"]),
                            // customDetails('seller'.tr + ' ' + 'name'.tr + ': ', ds["Seller_Name"]),
                            // customDetails('price'.tr + ': ', ds["Price"]),
                            // customDetails('date'.tr + ': ', ds["Date"]),
                            Row(
                              children: [
                                BoldText('seller'.tr + ' ' + 'name'.tr + ': '),
                                SimpleText(ds["Seller_Name"])
                              ],
                            ),
                            Row(
                              children: [
                                BoldText('name'.tr + ': '),
                                SimpleText(ds["Item"])
                              ],
                            ),
                            Row(
                              children: [
                                BoldText("address".tr + ': '),
                                SimpleText(ds["Address"])
                              ],
                            ),
                          ],
                        ),
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
                                  removeData(ds.id);
                                },
                                child: const Icon(Icons.delete,color: Colors.white,)),
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