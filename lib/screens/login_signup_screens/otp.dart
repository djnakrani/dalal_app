import 'package:dalal_app/constants/imports.dart';

class Otp extends StatefulWidget {
  final String phone;
  const Otp({Key? key, required this.phone}) : super(key: key);
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  late String _verificationCode;
  late String _code;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? uid;

  final GlobalKey<FormState> _otpForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _verifyphone();
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
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: const <Widget>[
                    Center(
                      child: CustomLogo(
                        logoSize: 300.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Form(
                  key: _otpForm,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "+91${widget.phone} " + "otpsend".tr,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      Container(
                          height: 50,
                          margin: syh20v5,
                          child: CustomTextfield(
                            myIcon: Icons.password,
                            inputType: TextInputType.number,
                            inputTxt: 'Otp',
                            maxsize: 6,
                            voidReturn: (value) {
                              _code = value;
                            },
                            validationData: (data) {
                              if (data.isEmpty) {
                                return "Enter OTP";
                              }
                            },
                          )),
                      Container(
                        alignment: Alignment.centerRight,
                        child: MaterialButton(
                          onPressed: () {
                            _verifyphone();
                          },
                          child: Text(
                            "otpresend".tr + "?",
                            style: const TextStyle(
                              color: myColors.btnRemove,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: syv10 + syh20,
                        child: CustomButton(
                            btnTxt: 'next'.tr,
                            callback: () async {
                              if (_otpForm.currentState!.validate()) {
                                _verifyOtp();
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _verifyphone() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91" + widget.phone,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAuthRetrievalTimeout,
        timeout: const Duration(milliseconds: 60000));
  }

  void verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    await _auth.signInWithCredential(phoneAuthCredential);
    if (_auth.currentUser != null) {
      setState(() {
        uid = _auth.currentUser?.uid;
      });
    } else {
      AlertShow("Error", Icons.error, "Retry");
    }
  }

  void verificationFailed(FirebaseAuthException error) {
    AlertShow("Error", Icons.error, error.message.toString());
  }

  void codeSent(String verificationId, [int? a]) async {
    setState(() {
      _verificationCode = verificationId;
    });
  }

  void codeAuthRetrievalTimeout(String verificationId) {
    setState(() {
      _verificationCode = verificationId;
    });
  }

  void _verifyOtp() async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationCode,
      smsCode: _code,
    );

    var user =await _auth.signInWithCredential(credential);
    FirebaseFirestore.instance
        .collection('User')
        .doc(user.user!.uid)
        .get()
        .then((value) {
      Get.log(value["IsAdmin"].toString());
      if (value["IsAdmin"] == "1") {
        Get.offAll(() => const AdminDashboard());
      } else if (value["IsAdmin"] == "0") {
        Get.offAll(() => const Home());
      }
    }).onError((error, stackTrace) {
      Get.log(error.toString());
      Get.offAll(() => const Signup());
    });
  }
}
