import 'package:dalal_app/constants/imports.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final lang = GetStorage();
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
              Column(
                children: const <Widget>[
                  Center(
                      child: CustomLogo(
                    logoSize: 300.0,
                  )),
                ],
              ),
              CustomLanguageButton(
                button: "English",
                callback: () {
                  Get.log("English");
                  lang.write('mylang',"English");
                  Get.updateLocale(Locale('en','US'));
                  Get.offAll(() => const Login());
                },
                btnImage: Images.languageUS,
              ),
              CustomLanguageButton(
                button: "हिन्दी",
                callback: () {
                  Get.log("Hindi");
                  lang.write('mylang',"Hindi");
                  Get.updateLocale(Locale('hi','IN'));
                  Get.offAll(() => const Login());
                },
                btnImage: Images.languageIN,

              ),
              CustomLanguageButton(
                button: "ગુજરાતી",
                callback: () {
                  Get.log("Gujarati");
                  lang.write('mylang',"Gujarati");
                  Get.updateLocale(Locale('gu','IN'));
                  Get.offAll(() => const Login());
                },
                btnImage: Images.languageIN,

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomLanguageButton extends StatelessWidget {
  final String button;
  final VoidCallback callback;
  final String btnImage;
  const CustomLanguageButton(
      {Key? key, required this.button, required this.callback,required this.btnImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Container(
          width: 200,
          // height: ,
          child: Row(
            children: [
              Ink.image(
                  height: 30, width: 30, image: AssetImage(btnImage)),
              SizedBox(
                width: 10,
              ),
              Text(
                button,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          )),
      color: myColors.colorPrimaryColor,
      textColor: Colors.white,
      onPressed: callback,
    );
  }
}
