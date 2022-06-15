import 'package:dalal_app/constants/imports.dart';
import 'package:url_launcher/url_launcher.dart';

class InputYTLink extends StatefulWidget {
  const InputYTLink({Key? key}) : super(key: key);

  @override
  _InputYTLinkState createState() => _InputYTLinkState();
}

class _InputYTLinkState extends State<InputYTLink> {
  late String _link;
  late String _title;
  final _youtubeForm = GlobalKey<FormState>();
  String? finalDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SimpleText('appTitle'.tr),
        backgroundColor: myColors.colorPrimaryColor,
      ),
      drawer: const AdminDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.background), fit: BoxFit.fill)),
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _youtubeForm,
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                      constraints: const BoxConstraints(maxHeight: 120),
                      margin: ot80,
                      child: BoldText('Add Link')),
                ),
                Container(
                  height: 40,
                  margin: syh20v5 + syv10,
                  child: CustomTextfield(
                    myIcon: Icons.location_city,
                    inputType: TextInputType.text,
                    inputTxt: 'title'.tr,
                    voidReturn: (value) {
                      _title = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "this is Required";
                      }
                    },
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5 + syv10,
                  child: CustomTextfield(
                    myIcon: Icons.location_city,
                    inputType: TextInputType.text,
                    inputTxt: 'link'.tr,
                    voidReturn: (value) {
                      _link = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "This is Required";
                      }
                    },
                  ),
                ),
                Container(
                  margin: syv10 + syh20,
                  child: CustomButton(
                    btnTxt: 'add'.tr,
                    callback: () {
                      if (_youtubeForm.currentState!.validate()) {
                        var date = DateTime.now().toString();
                        var dateParse = DateTime.parse(date);
                        var formattedDate =
                            "${dateParse.day}-${dateParse.month}-${dateParse.year}";
                        setState(() {
                          finalDate = formattedDate.toString();
                        });
                        Map<String, dynamic> data = {
                          "Title": _title,
                          "Link": _link,
                          "Date": finalDate,
                        };
                        addYtLink(data);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      dataTableTitle('title'.tr, myColors.colorPrimaryColor),
                      dataTableTitle('link'.tr, myColors.colorPrimaryColor),
                      dataTableTitle('date'.tr, myColors.colorPrimaryColor),
                      dataTableTitle('delete'.tr, myColors.btnRemove),
                    ],
                  ),
                ),
                Container(
                  margin: ah10,
                  height: MediaQuery.of(context).size.height / 100 * 50,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('YoutubeLink')
                              .orderBy("Date", descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: snapshot.data!.docs.map((doc) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: SimpleText(doc['Title'])),
                                          Expanded(
                                              child: InkWell(
                                            child: SimpleText(doc['Link']),
                                            onTap: () async {
                                              final wsurl = doc['Link'];
                                              if (await canLaunchUrl(wsurl)) {
                                                await launchUrl(wsurl);
                                              } else {
                                                throw "Not work";
                                              }
                                            },
                                          )),
                                          Expanded(
                                              child: SimpleText(doc['Date'])),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () => removeData(doc.id),
                                              child: const Icon(
                                                Icons.highlight_remove,
                                                color: myColors.btnRemove,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addYtLink(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('YoutubeLink')
        .doc()
        .set(data)
        .then((value) => () {
              AlertShow('Success', Icons.check, 'Number Added..');
              Get.offAll(() => const InputYTLink());
            })
        .catchError((onError) {
      AlertShow("Error", Icons.error, onError);
    });
  }

  dataTableTitle(String s, Color color) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: br20,
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SimpleText(s),
      ),
    ));
  }

  Future removeData(String docId) async {
    await FirebaseFirestore.instance
        .collection('YoutubeLink')
        .doc(docId)
        .delete()
        .then((value) => {
              AlertShow('Success', Icons.check, "Link Removed"),
              Get.off(() => const InputYTLink())
            });
  }
}
