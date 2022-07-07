import 'dart:io';
import 'package:dalal_app/constants/imports.dart';
import 'package:image_picker/image_picker.dart';

class InputForm extends StatefulWidget {
  String category;
  InputForm({Key? key, required this.category}) : super(key: key);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  String? _name,
      _mobile,
      _title,
      _price,
      _details,
      _address,
      _city,
      _state,
      _taluko;
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImage = [];
  var length;
  final _inputForm = GlobalKey<FormState>();
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
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.background), fit: BoxFit.fill)),
          height: Get.size.height,
          child: Form(
            key: _inputForm,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 60),
                    margin: ot50,
                    child: CustomText(
                        text: 'producttitle'.tr + ' ' + 'add'.tr,
                        fontWeight: FontWeight.bold,
                        size: 16.0),
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5,
                  child: CustomTextfield(
                    myIcon: Icons.title,
                    inputType: TextInputType.text,
                    inputTxt: 'title'.tr,
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
                    myIcon: Icons.price_change,
                    inputType: TextInputType.number,
                    inputTxt: 'price'.tr,
                    voidReturn: (value) {
                      _price = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "Required";
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
                    inputTxt: 'description'.tr,
                    voidReturn: (value) {
                      _details = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "Required";
                      }
                    },
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5,
                  child: CustomTextfield(
                    myIcon: Icons.my_location,
                    inputType: TextInputType.multiline,
                    maxLine: 4,
                    inputTxt: 'address'.tr,
                    voidReturn: (value) {
                      _address = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "Required";
                      }
                    },
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5,
                  child: CustomTextfield(
                    myIcon: Icons.location_on,
                    inputType: TextInputType.text,
                    inputTxt: 'city'.tr,
                    voidReturn: (value) {
                      _city = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "Required";
                      }
                    },
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5,
                  child: CustomTextfield(
                    myIcon: Icons.local_police,
                    inputType: TextInputType.text,
                    inputTxt: 'taluko'.tr,
                    voidReturn: (value) {
                      _taluko = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "Required";
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
                    inputTxt: 'state'.tr,
                    voidReturn: (value) {
                      _state = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "Required";
                      }
                    },
                  ),
                ),
                (length != 0)
                    ? InkWell(
                        child: const Icon(Icons.close),
                        onTap: () => resetPicker(),
                      )
                    : const SizedBox(),
                (length == 0)
                    ? InkWell(
                        onTap: () => chooseImage(),
                        child: Column(
                          children: [
                            CustomText(text: "Maximum 4 Photos Upload"),
                            Container(
                              decoration: BoxDecoration(
                                  color: myColors.btnTextColor,
                                  border: Border.all(
                                      color: myColors.colorPrimaryColor),
                                  borderRadius: br20),
                              margin: syv10 + syh20 + syh20,
                              padding: syv40 / 2,
                              child: const Icon(
                                Icons.add,
                                size: 80,
                                color: myColors.colorPrimaryColor,
                              ),
                            ),
                          ],
                        ))
                    : buildGridView(),
                Container(
                  margin: syv10 + syh20,
                  child: CustomButton(
                    btnTxt: 'add'.tr,
                    callback: () {
                      if (_inputForm.currentState!.validate()) {
                        if (_selectedImage.isNotEmpty) {
                          uploadOneByOne(_selectedImage);
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
                        margin: syh20 * 9,
                        child: const CircularProgressIndicator())
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> chooseImage() async {
    _selectedImage.clear();
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images!.isNotEmpty) {
        _selectedImage.addAll(images);
      }
    } catch (e) {
      Get.log(e.toString());
    }
    if (_selectedImage.length > 4) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Maximum 4 Photos Allowed")));
      setState(() {
        length = 0;
        _selectedImage.clear();
      });
    }
    setState(() {
      length = _selectedImage.length;
    });
    // Get.log(length);
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

  addData() async {
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

    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var finalDate = formattedDate.toString();
    Map<String, dynamic> data = {
      "Uid": uid,
      "Seller_Name": _name,
      "MobileNo": _mobile,
      "Category": widget.category,
      "Details": _details,
      "Item": _title,
      "Price": _price,
      "Address": _address,
      "City": _city,
      "Taluko": _taluko,
      "State": _state,
      "Date": finalDate,
      "Urls": _imagesUrlsList,
    };
    addItems(data);
  }

  void uploadOneByOne(List<XFile> _images) async {
    setState(() {
      isUploading = true;
    });
    _imagesUrlsList.clear();
    for (int i = 0; i < _images.length; i++) {
      await uploadFile(_images[i]).then((value) => _imagesUrlsList.add(value));
      // _imagesUrlsList.add(uploadFile(_images[i]).toString());
    }
    addData();
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

  Future<void> addItems(Map<String, dynamic> data) async {
    Get.log(data.toString());
    await FirebaseFirestore.instance
        .collection('Items')
        .doc()
        .set(data)
        .whenComplete(() => Get.offAll(() => const Home()))
        .onError((error, stackTrace) =>
            AlertShow("Error", Icons.error, error.toString()));
    _imagesUrlsList.clear();
  }

  resetPicker() {
    _selectedImage.clear();
    setState(() {
      length = _selectedImage.length;
    });
  }
}
