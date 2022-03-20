import 'package:dalal_app/constants/Images.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/screens/Input_screens/input_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/style.dart';

class TakeScreen extends StatefulWidget {
  @override
  _TakeScreenState createState() => _TakeScreenState();
}

class _TakeScreenState extends State<TakeScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> list1 = ["ગાય-ભેંશ","ખેતી-પાક","ખેતી-ઓજારો","ખેતી-વાહન","અન્ય-વાહન","એગ્રો-દવા","મકાન","જમીન"];
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
      // title: const Text('What You Add....'),
      child: Container(
          width: double.maxFinite,
          child:Column(
            children: [
              Container(child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(primary: myColors.colorPrimaryColor),
                        child: Row(
                      children: [
                        Image.asset(Images.logoImage,height: 50.h,width: 50.w),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,left: 5.0),
                          child: Text("  ખેડૂત હેલ્પલાઈન નંબર ",style:TextStyle(fontSize: 30.w,),),
                        )
                      ],

                    )),
                  )
                ],
              )),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: list1.length,
                  padding: EdgeInsets.all(5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0
                  ),
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      margin: ah10,
                          child: ElevatedButton(onPressed: () {
                            Get.to(InputForm());
                            },
                              child: Text(list1[index],style: TextStyle(fontSize: 25),)),
                      // child: Image.asset(Images.logoImage),
                    );
                  },
                ),
              ),
              Container(child: Column(
                children: [
                  ElevatedButton(onPressed: (){
                    Get.back();
                  },
                    child:
                      Text(" Close ",),
                  )
                ],
              )),
            ],
          )),
    );
  }
}