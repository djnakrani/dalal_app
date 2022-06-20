import 'package:dalal_app/constants/imports.dart';

class AllPost extends StatefulWidget {
  const AllPost({Key? key}) : super(key: key);

  @override
  _AllPostState createState() => _AllPostState();
}

class _AllPostState extends State<AllPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SimpleText('appTitle'.tr),
        backgroundColor: myColors.colorPrimaryColor,
      ),
      drawer: const AdminDrawer(),
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
                                  boldText('seller'.tr + ' ' + 'name'.tr),
                                  SimpleText(ds["Seller_Name"])
                                ],
                              ),
                              Row(
                                children: [
                                  boldText('name'.tr),
                                  SimpleText(ds["Item"])
                                ],
                              ),
                              Row(
                                children: [
                                  boldText("address".tr),
                                  SimpleText(ds["Address"])
                                ],
                              ),
                              Row(
                                children: [
                                  boldText('mobileNo'.tr),
                                  SimpleText(ds["MobileNo"])
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
                                      removeData(ds.id);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: myColors.btnRemove,
                                    )),
                              ),
                            ],
                          ),
                        )
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
        .then((value) => {
      AlertShow('Success',Icons.check,'Item Removed Successfully'),
      Get.off(() => const AllPost())});
  }

}

