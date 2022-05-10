import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/constants/string.dart';
import 'package:dalal_app/screens/filter_screens/filterscreen.dart';
import 'package:dalal_app/screens/messageBox.dart';
import 'package:dalal_app/screens/mydrawer.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/custom_text.dart';
import '../home_screens/home.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var selectedItem = null;
  var selectedArea = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SimpleText(string.appName + " - Filter"),
        backgroundColor: myColors.colorPrimaryColor,
        actions: [
          IconButton(
              onPressed: () => Get.off(() => const Home()),
              icon: const Icon(Icons.home))
        ],
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: syh20v5,
          padding: syv5,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 5) +
                    ob50 / 2,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: br20,
                ),
                child: getItems(),
              ),
              CustomTextfield(
                  inputTxt: "Search In Your City",
                  inputType: TextInputType.text,
                  myIcon: Icons.location_city,
                  voidReturn: (value) {
                    selectedArea = value;
                  },
                  validationData: (data) {}),
              Container(
                margin: syv10 + syh20,
                child: CustomButton(
                    btnTxt: 'આગળ વધો',
                    callback: () {
                      if (selectedItem == null) {
                        showDialog(
                          context: context,
                          builder: (_) => MessageBox(
                            msg: 'કંઈક સિલેક્ટ કરો ',
                            icon: Icons.error,
                          ),
                        );
                      } else {
                        Get.off(() => FilterScreen(
                              items: selectedItem,
                              area: selectedArea,
                            ));
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getItems() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Category').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: syh20 / 2,
                  child: DropdownButton(
                    style: const TextStyle(color: myColors.colorPrimaryColor),
                    isExpanded: true,
                    borderRadius: br20,
                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        selectedItem = valueSelectedByUser.toString();
                      });
                      Get.log(selectedItem);
                    },
                    value: selectedItem,
                    hint: SimpleText("Select Items"),
                    items: snapshot.data!.docs.map((document) {
                      return DropdownMenuItem(
                        value: document['Type'].toString(),
                        child: SimpleText(document['Type']),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
