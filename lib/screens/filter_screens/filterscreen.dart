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
                      if (widget.area == "" ||
                          ds["City"].toString().contains(widget.area) ||
                          ds["Address"].toString().contains(widget.area) ||
                          ds["State"].toString().contains(widget.area) ||
                          ds["Taluka"].toString().contains(widget.area)) {
                        return cardView(ds);
                      } else {
                        return const SizedBox();
                      }
                    });
              }
            },
          )),
    );
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
