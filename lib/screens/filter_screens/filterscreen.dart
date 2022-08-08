import 'package:dalal_app/screens/filter_screens/searchscreen.dart';
import 'package:dalal_app/constants/imports.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: MyString.appName,
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
                          // ds["Seller_Name"].toString().contains(widget.area) ||
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
}
