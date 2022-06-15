import 'package:dalal_app/constants/imports.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String totalUser = "";
  String totalItems = "";
  String totalYouLink = "";
  String totalHelpLineNo = "";

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      setState(() {
        totalUser = value;
      });
    });
    getItems().then((value) {
      setState(() {
        totalItems = value;
      });
    });
    getYoutubeLinks().then((value) {
      setState(() {
        totalYouLink = value;
      });
    });
    getHelpLineNo().then((value) {
      setState(() {
        totalHelpLineNo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SimpleText('appTitle'.tr),
        backgroundColor: myColors.colorPrimaryColor,
      ),
      drawer: const AdminDrawer(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                viewCard(Colors.amberAccent, "User",
                    Icons.supervised_user_circle, totalUser),
                viewCard(Colors.green, "Items", Icons.view_list, totalItems),
                viewCard(Colors.redAccent, "Youtube Links",
                    Icons.play_circle_fill, totalYouLink),
                viewCard(Colors.lightGreen, "HelpLine Numbers", Icons.view_list,
                    totalHelpLineNo),
              ],
            )),
      ),
    );
  }

  Widget viewCard(
    Color cardColor,
    String category,
    IconData icon,
    String number,
  ) {
    return Card(
      margin: syv10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40), // if you need this
        side: BorderSide(
          color: cardColor,
          width: 1,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: br20,
          color: cardColor,
        ),
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0) + syh20 * 2,
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: Icon(
                      icon,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 70,
                    child: SimpleText(number), //CircleAvatar
                  ),
                ],
              ),
              SimpleText(category),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getUser() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection('User').get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    return _myDocCount.length.toString();
  }

  Future<String> getItems() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection('Items').get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    return _myDocCount.length.toString();
  }

  Future<String> getYoutubeLinks() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection('YoutubeLink').get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    return _myDocCount.length.toString();
  }

  Future<String> getHelpLineNo() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection('HelpLineNo').get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    return _myDocCount.length.toString();
  }
}
