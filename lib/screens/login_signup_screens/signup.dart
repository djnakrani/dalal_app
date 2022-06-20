import 'package:dalal_app/constants/imports.dart';

class Signup extends StatefulWidget {
  const Signup({
    Key? key,
  }) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? _name, _email, _address, _city, _dist, _taluka;
  String? uid;
  String? _mno;
  final _signUpForm = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // Get.log(FirebaseAuth.instance.currentUser!.uid.toString());
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      uid = FirebaseAuth.instance.currentUser!.uid;
      _mno = FirebaseAuth.instance.currentUser!.phoneNumber;
      Get.log(_mno.toString());
    }
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
            key: _signUpForm,
            child: Column(
              children: <Widget>[
                const Center(
                    child: CustomLogo(
                  logoSize: 120.0,
                )),
                Container(
                  height: 40,
                  margin: syh20v5 + syv10,
                  child: CustomTextfield(
                    myIcon: Icons.person,
                    inputType: TextInputType.text,
                    inputTxt: 'name'.tr,
                    voidReturn: (value) {
                      _name = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "Name Is Required";
                      }
                    },
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5 + syv10,
                  child: CustomTextfield(
                    myIcon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    inputTxt: 'email'.tr,
                    voidReturn: (value) {
                      _email = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "Email is Required.";
                      }
                    },
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5 + syv10,
                  child: CustomTextfield(
                    myIcon: Icons.location_city,
                    inputType: TextInputType.multiline,
                    maxLine: 4,
                    inputTxt: 'address'.tr,
                    voidReturn: (value) {
                      _address = value;
                    },
                    validationData: (data) {},
                  ),
                ),
                Container(
                  height: 40,
                  margin: syh20v5 + syv10,
                  child: CustomTextfield(
                    myIcon: Icons.location_city,
                    inputType: TextInputType.text,
                    inputTxt: 'taluko'.tr,
                    voidReturn: (value) {
                      _taluka = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "This is required";
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
                    inputTxt: 'city'.tr,
                    voidReturn: (value) {
                      _city = value;
                    },
                    validationData: (data) {
                      if (data.isEmpty) {
                        return "This is required";
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
                    inputTxt: 'state'.tr,
                    voidReturn: (value) {
                      _dist = value;
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
                    btnTxt: 'next'.tr,
                    callback: () {
                      if (_signUpForm.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          "Name": _name,
                          "Address": _address,
                          "Mobile_no": _mno,
                          "Email": _email,
                          "District": _dist,
                          "Taluka": _taluka,
                          "City": _city,
                          "IsAdmin": "0",
                        };
                        Get.log(data.toString());
                        addUsers(data);
                        Get.offAll(() => const Home());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addUsers(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .set(data)
        .then((value) => () {
              AlertShow("Success", Icons.check, "");
            })
        .catchError((onError) {
      AlertShow("Error", Icons.error, onError.toString());
    });
  }
}
