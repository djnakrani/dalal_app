import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/screens/login_signup_screens/signup.dart';
import 'package:dalal_app/screens/messageBox.dart';
import 'package:dalal_app/widget/custom_button.dart';
import 'package:dalal_app/widget/custom_logo.dart';
import 'package:dalal_app/widget/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/Images.dart';
import '../admin_screens/dashboard.dart';
import '../home_screens/home.dart';

class Otp extends StatefulWidget {
  final String phone;
  const Otp({Key? key, required this.phone}) : super(key: key);
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  late String _verificationCode;
  late String _code;

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
                        "Otp Sent +91${widget.phone}",
                        style: const TextStyle(color: Colors.red, fontSize: 20),
                      ),
                      Container(
                          height: 50,
                          margin: syh20v5,
                          child: CustomTextfield(
                            myIcon: Icons.password,
                            inputType: TextInputType.number,
                            inputTxt: 'Otp દાખલ કરો ...',
                            maxsize: 6,
                            voidReturn: (value) {
                              _code = value;
                            },
                            validationData: (data) {
                              if (data.isEmpty) {
                                return "Please Fill OTP";
                              }
                            },
                          )),
                      Container(
                        alignment: Alignment.centerRight,
                        child: MaterialButton(
                          onPressed: () {
                            _verifyphone();
                          },
                          child: const Text(
                            "Resend Otp?",
                            style: TextStyle(
                              color: myColors.btnRemove,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: syv10 + syh20,
                        child: CustomButton(
                            btnTxt: 'આગળ વધો',
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
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91" + widget.phone,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAuthRetrievalTimeout,
      // timeout: Duration(seconds: 60)
    );
  }

  void verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
    if (FirebaseAuth.instance.currentUser != null) {
      setState(() {
        uid = FirebaseAuth.instance.currentUser?.uid;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => MessageBox(
          msg: 'Something Went Wrong',
          icon: Icons.error,
        ),
      );
    }
  }

  void verificationFailed(FirebaseAuthException error) {
    showDialog(
      context: context,
      builder: (_) => MessageBox(
        msg: error.message.toString(),
        icon: Icons.error,
      ),
    );
  }

  void codeSent(String verificationId, [int? a]) {
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

    try {
      await FirebaseAuth.instance.signInWithCredential(credential).whenComplete((){
        if (FirebaseAuth.instance.currentUser != null) {
          Get.log("hello");
          uid = FirebaseAuth.instance.currentUser!.uid;
          FirebaseFirestore.instance
              .collection('User')
              .doc(uid)
              .get()
              .then((value) {
            if (value["IsAdmin"] == "1") {
              Get.log("hello2");

              Get.offAll(() => const AdminDashboard());
            } else if (value["IsAdmin"] == "") {
              Get.log("hello3");

              Get.offAll(() => const Signup());
            } else {
              Get.log("hello4");

              Get.offAll(() => const Home());
            }
          });
        }
      });
      // FirebaseAuth.instance.signInWithPhoneNumber(widget.phone);
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => MessageBox(
          msg: e.toString(),
          icon: Icons.error,
        ),
      );
    }
  }
}
