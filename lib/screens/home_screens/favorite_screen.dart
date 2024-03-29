import 'package:dalal_app/screens/home_screens/cardView.dart';
import 'package:dalal_app/constants/imports.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  var favItems = [];

  @override
  void initState() {
    super.initState();
    favItems.clear();
    FirebaseFirestore.instance
        .collection('Favorite')
        .doc(uid)
        .get()
        .then((value) {
      var snapshotdata = value.data() as Map;
      for (var a in snapshotdata["Items"]) {
        if (favItems.contains(a)) {
        } else {
          setState(() {
            favItems.add(a);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(string.appName),
        backgroundColor: myColors.colorPrimaryColor,
      ),
      drawer: const MyDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Items').where(FieldPath.documentId,whereIn: favItems).snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                // Get.log(FieldPath.documentId.name);
                    return ListView.builder(
                            itemCount: favItems.length,
                            padding: ob50,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds = snapshot.data!.docs[index];
                              return cardView(ds);
                            });

              }
            },
          )),
    );
  }
}
