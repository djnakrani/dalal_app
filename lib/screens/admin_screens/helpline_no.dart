import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/messageBox.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:get/get.dart';

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.background), fit: BoxFit.fill)),
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _helplineno,
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 120),
                    margin: ot80,
                    child: const Text(
                      "હેલ્પલાઈન નંબર ઉમેરો",
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5 + syv10,
                  child: CustomTextfield(
                    myIcon: Icons.location_city,
                    inputType: TextInputType.text,
                    inputTxt: 'તાલુકો',
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
                    myIcon: Icons.numbers,
                    inputType: TextInputType.text,
                    inputTxt: 'નંબર',
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
                    btnTxt: 'ઉમેરો...',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      dataTableTitle('તાલુકો', myColors.colorPrimaryColor),
                      dataTableTitle('નંબર', myColors.colorPrimaryColor),
                      dataTableTitle('કાઢો', myColors.btnRemove),
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
                              .collection('HelpLineNo')
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
                                          Expanded(child: Text(doc['Taluko'])),
                                          Expanded(child: Text(doc['Number'])),
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
              MessageBox(
                msg: 'Number Added Successfully',
                icon: Icons.check,
              );
              Get.offAll(() => const HelpLineno());
            })
        .catchError((onError) {
      MessageBox(
        msg: onError,
        icon: Icons.error,
      );
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
        .collection('HelpLineNo')
        .doc(docId)
        .delete()
        .then((value) => {
              showDialog(
                context: context,
                builder: (_) => MessageBox(
                  msg: 'Number Removed Successfully',
                  icon: Icons.check,
                ),
              ),
              Get.off(() => const HelpLineno())
            });
  }
}
