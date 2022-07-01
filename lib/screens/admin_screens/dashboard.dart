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
        title: CustomText(
            text: 'appTitle'.tr,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            size: 18.0),
        backgroundColor: myColors.colorPrimaryColor,
      ),
      drawer: const AdminDrawer(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                viewCard(Color.fromARGB(255, 32, 114, 0), "User",
                    Icons.supervised_user_circle, totalUser),
                viewCard(Color.fromARGB(255, 41, 145, 0), "Items",
                    Icons.view_list, totalItems),
                viewCard(Color.fromARGB(255, 48, 170, 0), "Youtube Links",
                    Icons.play_circle_fill, totalYouLink),
                viewCard(Color.fromARGB(255, 62, 219, 0), "Helpline No",
                    Icons.view_list, totalHelpLineNo),
              ],
            )),
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

Widget viewCard(
  Color cardColor,
  String category,
  IconData icon,
  String number,
) {
  return Card(
    margin: syv10 / 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // if you need this
      side: BorderSide(
        color: cardColor,
        width: 1,
      ),
    ),
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: br20,
        color: cardColor,
      ),
      width: Get.size.width,
      height: 180.h,
      // child: Padding(
      //   padding: syv10 * 2 + syh20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Spacer(),
              Column(children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: Icon(
                    icon,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
                CustomText(
                  text: category,
                  size: 22.sp,
                  color: Colors.white,
                ),
              ]),
              const SizedBox(
                width: 20,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70,
                child: CustomText(
                  text: number,
                  size: 40.0,
                  fontWeight: FontWeight.bold,
                ), //CircleAvatar
              ),
              Spacer(),
            ],
          ),
        ],
        // ),
      ),
    ),
  );
}
