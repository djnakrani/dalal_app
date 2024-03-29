import 'package:dalal_app/constants/imports.dart';
import 'package:dalal_app/screens/filter_screens/filterscreen.dart';
import 'package:flutter/cupertino.dart';

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
        title: CustomText(
            text: 'appTitle'.tr,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            size: 18.0),
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
                margin: EdgeInsets.only(top: Get.size.height / 5) + ob50 / 2,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: myColors.colorPrimaryColor,
                  ),
                  borderRadius: br20 / 2,
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
                    btnTxt: 'next'.tr,
                    callback: () {
                      if (selectedItem == null) {
                        AlertShow('Error', Icons.error, "Not Selected");
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
                    },
                    value: selectedItem,
                    hint: CustomText(text: "Select Items"),
                    items: snapshot.data!.docs.map((document) {
                      return DropdownMenuItem(
                        value: document.id,
                        child: CustomText(text: document['Type']),
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
