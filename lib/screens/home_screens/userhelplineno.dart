import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UserHelpLine extends StatefulWidget {
  const UserHelpLine({Key? key}) : super(key: key);

  @override
  _UserHelpLineState createState() => _UserHelpLineState();
}

class _UserHelpLineState extends State<UserHelpLine> {
  var area = "";
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
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  margin: ot80,
                  child: const Text(
                    "હેલ્પલાઈન નંબર",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                        inputTxt: "Search",
                        inputType: TextInputType.text,
                        myIcon: Icons.location_city,
                        voidReturn: (value) {
                          area = value;
                        },
                        validationData: (data) {}),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Get.log(area);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: br20),
                          primary: myColors.colorPrimaryColor),
                      child: const Icon(Icons.search)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    dataTitleTable('તાલુકો', myColors.colorPrimaryColor),
                    dataTitleTable('નંબર', myColors.colorPrimaryColor),
                  ],
                ),
              ),
              Container(
                margin: ah10,
                height: MediaQuery.of(context).size.height / 1.5,
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
                                if (area == "" ||
                                    doc['Taluko'].toString().contains(area)) {
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
                                                  onTap: () => {
                                                    launch(
                                                        'tel: +91${doc['Number']}')
                                                  },
                                                  child: const Icon(
                                                    Icons.phone,
                                                    color: myColors
                                                        .colorPrimaryColor,
                                                  ))),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                else{
                                  return SizedBox();
                                }
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
    );
  }

  dataTitleTable(String s, Color color) {
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
}
