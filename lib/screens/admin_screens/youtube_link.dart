import 'package:dalal_app/constants/imports.dart';

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
        title: CustomText(
            text: MyString.appName,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            size: 18.0),
        backgroundColor: myColors.colorPrimaryColor,
      ),
      drawer: const AdminDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.background), fit: BoxFit.fill)),
          height: Get.size.height / 1.1,
          child: Form(
            key: _youtubeForm,
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    margin: ot50 / 3,
                    child: const CustomText(
                      text: "Add Youtube Link",
                      fontWeight: FontWeight.bold,
                      size: 18.0,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5 + syv10,
                  child: CustomTextfield(
                    myIcon: Icons.title,
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
                    myIcon: Icons.link,
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
                    btnTxt: "Add Link",
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
                const Divider(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      dataTableTitle('title'.tr),
                      dataTableTitle('link'.tr),
                      dataTableTitle('date'.tr),
                      dataTableTitle('delete'.tr),
                    ],
                  ),
                ),
                Container(
                  margin: ah10,
                  height: Get.size.height / 100 * 50,
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
                                              child: CustomText(
                                                  text: doc['Title'])),
                                          Expanded(
                                              child: InkWell(
                                            child:
                                                CustomText(text: doc['Link']),
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
                                              child: CustomText(
                                                  text: doc['Date'])),
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
              alertShow('Success', Icons.check, 'Number Added..');
              _youtubeForm.currentState!.reset();
            })
        .catchError((onError) {
      alertShow("Error", Icons.error, onError);
    });
  }

  Future removeData(String docId) async {
    await FirebaseFirestore.instance
        .collection('YoutubeLink')
        .doc(docId)
        .delete()
        .then((value) => {
              alertShow('Success', Icons.check, "Link Removed"),
              Get.offAll(() => const InputYTLink())
            });
  }
}
