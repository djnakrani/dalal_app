import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/messageBox.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:get/get.dart';
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
                    child: const Text(
                      " તમારા ની વિગત નાખો ",
                      style: TextStyle(fontSize: 38),
                    ),
                    // child: Image.asset(Images.logoImage),
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5 + syv10,
                  child: CustomTextfield(
                    myIcon: Icons.location_city,
                    inputType: TextInputType.text,
                    inputTxt: ' શીર્ષક  ',
                    voidReturn: (value) {
                      _title = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "Title is Required";
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
                    inputTxt: 'લિંક નાખો  ',
                    voidReturn: (value) {
                      _link = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "Link is Required";
                      }
                    },
                  ),
                ),
                Container(
                  margin: syv10 + syh20,
                  child: CustomButton(
                    btnTxt: 'તમારી Link ઉમેરો ...',
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
                      dataTableTitle('Title', myColors.colorPrimaryColor),
                      dataTableTitle('Link', myColors.colorPrimaryColor),
                      dataTableTitle('Date', myColors.colorPrimaryColor),
                      dataTableTitle('Remove', myColors.btnRemove),
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
                                          Expanded(child: Text(doc['Title'])),
                                          Expanded(
                                              child: InkWell(
                                            child: Text(doc['Link']),
                                            onTap: () async {
                                              final wsurl = doc['Link'];
                                              if (await canLaunch(wsurl)) {
                                                await launch(wsurl);
                                              } else {
                                                throw "Not work";
                                              }
                                            },
                                          )),
                                          Expanded(child: Text(doc['Date'])),
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
      MessageBox(msg: 'Number Added Successfully',icon: Icons.check,);
      Get.offAll(() => const InputYTLink());
            })
        .catchError((onError) {
      MessageBox(msg: onError,icon: Icons.error,);
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
        child: Text(
          s,
          style: const TextStyle(color: myColors.btnTextColor),
        ),
      ),
    ));
  }

  Future removeData(String docId) async {
    await FirebaseFirestore.instance
        .collection('YoutubeLink')
        .doc(docId)
        .delete()
        .then((value) => {
      MessageBox(msg: 'Number Removed Successfully',icon: Icons.check,),
      Get.off(() => const InputYTLink())});
  }
}
