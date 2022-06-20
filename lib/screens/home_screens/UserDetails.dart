import 'dart:async';
import 'package:dalal_app/constants/imports.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  var _name,_email,_mno,_address,_city,_dist,_taluka;
  bool isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var uid = FirebaseAuth.instance.currentUser!.uid;
    Timer(const Duration(seconds: 1),(){
      setState(() {
        isloading = false;
      });
    });
    FirebaseFirestore.instance.collection('User').doc(uid).get().then((value) {
      setState(() {
        _name= value["Name"];
        _address= value["Address"];
        _mno= value["Mobile_no"];
        _email= value["Email"];
        _city= value["City"];
        _dist= value["District"];
        _taluka= value["Taluka"];
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text:'appTitle'.tr,color:Colors.white,fontWeight: FontWeight.bold,size: 14.0),
        backgroundColor: myColors.colorPrimaryColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.background), fit: BoxFit.fill)),
          height: Get.size.height,
          child:  Column(
            children: <Widget>[
              Center(
                child:Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  margin: ot80,
                  child: CustomText(fontWeight: FontWeight.bold,text:'mydetails'.tr)
                ),
              ),
              isloading?const CircularProgressIndicator():Container(
                margin: ah10,
                padding: syv10+syh20,
                height: Get.size.height/2 ,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customDetails('name'.tr + ":", _name),
                    customDetails('email'.tr + ":", _email),
                    customDetails('mobileNo'.tr + ":", _mno),
                    customDetails('address'.tr + ":", _address),
                    customDetails('state'.tr + ":", _dist),
                    customDetails('taluko'.tr + ":", _taluka),
                    customDetails('city'.tr + ":", _city),
                    Container(
                      margin: syv10 + syh20*5,
                      child: CustomButton(
                        btnTxt: 'edit'.tr,
                        callback: () {
                          Get.to(() => const Signup());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
