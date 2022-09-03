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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: 'appTitle'.tr,
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
                      return myCard(ds);
                    });
              }
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: bottomBar(),
    );
  }
}

Widget bottomBar() {
  return Padding(
    padding: ah10,
    child: FloatingActionButton.extended(
      backgroundColor: myColors.colorPrimaryColor,
      onPressed: () {
        Get.dialog(const TakeScreen());
      },
      isExtended: true,
      icon: const Icon(
        Icons.add,
        size: 40,
      ),
      label: CustomText(
        fontWeight: FontWeight.bold,
        text: 'postadd'.tr,
        color: Colors.white,
      ),
    ),
  );
}