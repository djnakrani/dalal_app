import 'package:dalal_app/constants/imports.dart';

class HelpLineno extends StatefulWidget {
  const HelpLineno({Key? key}) : super(key: key);

  @override
  _HelpLinenoState createState() => _HelpLinenoState();
}

class _HelpLinenoState extends State<HelpLineno> {
  late String _taluko;
  late String _number;
  final _helplineno = GlobalKey<FormState>();
  String? finalDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: 'appTitle'.tr,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            size: 14.0),
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
            key: _helplineno,
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    margin: ot50 / 3,
                    child: const CustomText(
                      text: "Add Helpline Number",
                      fontWeight: FontWeight.bold,
                      size: 18.0,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5 + syv10,
                  child: CustomTextfield(
                    myIcon: Icons.my_location,
                    inputType: TextInputType.text,
                    inputTxt: 'taluko'.tr,
                    voidReturn: (value) {
                      _taluko = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "This is Required";
                      }
                    },
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5 + syv10,
                  child: CustomTextfield(
                    myIcon: Icons.app_registration,
                    inputType: TextInputType.text,
                    maxsize: 10,
                    inputTxt: 'mobileNo'.tr,
                    voidReturn: (value) {
                      _number = value;
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
                    btnTxt: "Add Helpline Number",
                    callback: () {
                      if (_helplineno.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          "Taluko": _taluko,
                          "Number": _number,
                        };
                        addHelpLineno(data);
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
                      dataTableTitle('taluko'.tr),
                      dataTableTitle('mobileNo'.tr),
                      dataTableTitle('delete'.tr),
                    ],
                  ),
                ),
                Container(
                  margin: ah10,
                  height: Get.size.height / 100 * 50,
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: br20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('HelpLineNo')
                              .orderBy('Taluko')
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
                                                  text: doc['Taluko'])),
                                          Expanded(
                                              child: CustomText(
                                                  text: doc['Number'])),
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

  Future<void> addHelpLineno(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('HelpLineNo')
        .doc()
        .set(data)
        .then((value) => () {
              AlertShow('Success', Icons.check, 'Number Added Successfully');
              Get.offAll(() => const HelpLineno());
            })
        .catchError((onError) {
      AlertShow(Error, Icons.error, onError);
    });
  }

  Future removeData(String docId) async {
    await FirebaseFirestore.instance
        .collection('HelpLineNo')
        .doc(docId)
        .delete()
        .then((value) => {
              AlertShow('Success', Icons.check, 'Number Removed Successfully'),
              Get.off(() => const HelpLineno())
            });
  }
}
