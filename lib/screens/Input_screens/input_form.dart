import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/error.dart';
import 'package:dalal_app/screens/home_screens/home.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:image_picker/image_picker.dart';

class InputForm extends StatefulWidget {
  String Category;

  InputForm({Key? key, required this.Category}) : super(key: key);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  String? _name, _mobile, _title, _price, _details, _address, _city, _state;
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImage = [];
  var length;
  final _InputForm = GlobalKey<FormState>();
  FirebaseStorage _storageRef = FirebaseStorage.instance;
  List<String> _imagesUrlsList = [];

  bool isUploading = false;

  @override
  void initState() {
    setState(() {
      length = _selectedImage.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.background), fit: BoxFit.fitHeight)),
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _InputForm,
          child: ListView(
            children: <Widget>[
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 60),
                  margin: ot50,
                  child: Text(
                    " તમારા ${widget.Category} ની વિગત નાખો ",
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5,
                child: CustomTextfield(
                  myIcon: Icons.title,
                  inputType: TextInputType.text,
                  inputTxt: 'શીર્ષક',
                  voidReturn: (value) {
                    _title = value;
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
                  myIcon: Icons.price_check,
                  inputType: TextInputType.number,
                  inputTxt: 'કિંમત',
                  voidReturn: (value) {
                    _price = value;
                  },
                  validationData: (data) {
                    if (data.isEmpty) {
                      return "Data Required";
                    }
                  },
                ),
              ),
              Container(
                height: 70,
                margin: syh20v5,
                child: CustomTextfield(
                  myIcon: Icons.description,
                  maxLine: 5,
                  inputType: TextInputType.text,
                  inputTxt: 'વર્ણન',
                  voidReturn: (value) {
                    _details = value;
                  },
                  validationData: (data) {
                    if (data.isEmpty) {
                      return "Data Required";
                    }
                  },
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5,
                child: CustomTextfield(
                  myIcon: Icons.location_city_outlined,
                  inputType: TextInputType.multiline,
                  maxLine: 4,
                  inputTxt: 'તમારું સરનામું/ગામ નાખો. ',
                  voidReturn: (value) {
                    _address = value;
                  },
                  validationData: (data) {
                    if (data.isEmpty) {
                      return "Data Required";
                    }
                  },
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5,
                child: CustomTextfield(
                  myIcon: Icons.location_city,
                  inputType: TextInputType.text,
                  inputTxt: 'રાજ્ય',
                  voidReturn: (value) {
                    _state = value;
                  },
                  validationData: (data) {
                    if (data.isEmpty) {
                      return "Data Required";
                    }
                  },
                ),
              ),
              Container(
                height: 40,
                margin: syh20v5,
                child: CustomTextfield(
                  myIcon: Icons.location_city,
                  inputType: TextInputType.text,
                  inputTxt: 'જિલ્લો',
                  voidReturn: (value) {
                    _city = value;
                  },
                  validationData: (data) {
                    if (data.isEmpty) {
                      return "Data Required";
                    }
                  },
                ),
              ),
              (length != 0)
                  ? InkWell(
                      child: const Icon(Icons.close),
                      onTap: () => resetPicker(),
                    )
                  : SizedBox(),
              (length == 0)
                  ? InkWell(
                      onTap: () => chooseImage(),
                      child: Container(
                        decoration: BoxDecoration(
                            color: myColors.btnTextColor,
                            border:
                                Border.all(color: myColors.colorPrimaryColor),
                            borderRadius: br20),
                        margin: syv10 + syh20 + syh20 + syh20 + syh20 + syh20,
                        padding: syv40,
                        child: const Icon(
                          Icons.add,
                          color: myColors.colorPrimaryColor,
                        ),
                      ),
                    )
                  : buildGridView(),
              Container(
                margin: syv10 + syh20,
                child: CustomButton(
                  btnTxt: 'તમારી પોસ્ટ ઉમેરો ...',
                  callback: () {
                    if (_InputForm.currentState!.validate()) {
                      if (_selectedImage.isNotEmpty) {
                        uploadonebyone(_selectedImage);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please Select Image")));
                      }
                    }
                  },
                ),
              ),
              isUploading
                  ? Container(
                      margin: syh20 * 8,
                      child: const CircularProgressIndicator())
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> chooseImage() async {
    if (_selectedImage != null) {
      _selectedImage.clear();
    }
    try {
      final List<XFile>? imgs = await _picker.pickMultiImage();
      if (imgs!.isNotEmpty) {
        _selectedImage.addAll(imgs);
      }
    } catch (e) {
      Get.log(e.toString());
    }
    setState(() {
      length = _selectedImage.length;
    });
    Get.log(length);
  }

  Widget buildGridView() {
    Get.log(length.toString());
    return GridView.builder(
      shrinkWrap: true,
      itemCount: _selectedImage.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.file(
            File(_selectedImage[index].path),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  add_data() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    Get.log(uid.toString());
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .get()
        .then((value) {
      _name = value["Name"];
      _mobile = value["Mobile_no"];
    });

    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate =
        "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var finalDate = formattedDate.toString();
    Map<String, dynamic> data = {
      "Uid": uid,
      "Seller_Name": _name,
      "MobileNo": _mobile,
      "Categoty": widget.Category,
      "Details" : _details,
      "Item": _title,
      "Price": _price,
      "Address": _address,
      "City": _city,
      "State": _state,
      "Date": finalDate,
      "Urls": _imagesUrlsList,
    };
    Add_Items(data);
  }

  void uploadonebyone(List<XFile> _images) async {
    setState(() {
      isUploading = true;
    });
    _imagesUrlsList.clear();
    for (int i = 0; i < _images.length; i++) {
      await uploadFile(_images[i]).then((value) => _imagesUrlsList.add(value));
      // _imagesUrlsList.add(uploadFile(_images[i]).toString());
    }
    add_data();
    setState(() {
      isUploading = false;
    });
  }

  Future<String> uploadFile(XFile _image) async {
    Reference reference = _storageRef.ref().child("Items").child(_image.name);
    UploadTask uploadTask = reference.putFile(File(_image.path));
    await uploadTask.whenComplete(() {});
    return await reference.getDownloadURL();
  }

  Future<void> Add_Items(Map<String, dynamic> data) async {
    Get.log(data.toString());
    await FirebaseFirestore.instance
        .collection('Items')
        .doc()
        .set(data)
        .whenComplete(() => Get.offAll(() => Home()))
        .onError((error, stackTrace) => ErrorScreen(error: error.toString()));
    _imagesUrlsList.clear();
  }

  resetPicker() {
    _selectedImage.clear();
    setState(() {
      length = _selectedImage.length;
    });
  }
}
