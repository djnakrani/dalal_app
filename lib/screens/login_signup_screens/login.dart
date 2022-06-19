import 'package:dalal_app/constants/imports.dart';
import 'package:dalal_app/screens/login_signup_screens/otp.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? _mobileno;
  final _LoginForm = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
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
                    )),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Form(
                  key: _LoginForm,
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 50,
                          margin: syh20v5,
                          child: CustomTextfield(
                            myIcon: Icons.call,
                            inputType: TextInputType.number,
                            inputTxt: 'mobileNo'.tr ,
                            maxsize: 10,
                            voidReturn: (value) {
                              _mobileno = value;
                            },
                            validationData: (data) {
                              if (data.isEmpty) {
                                return "Enter Mobile Number";
                              }
                              if(data.length < 10){
                                return "Incorrect Mobile Number";
                              }
                            },
                          )),
                      Container(
                        margin: syv10 + syh20,
                        child: CustomButton(
                            btnTxt: 'next'.tr,
                            callback: () {
                              if (_LoginForm.currentState!.validate()) {
                                Get.to(() => Otp(phone: _mobileno!));
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
}
