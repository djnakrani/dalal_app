import 'package:dalal_app/screens/Input_screen/take_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/constants/string.dart';
import 'package:dalal_app/constants/Images.dart';
import 'package:url_launcher/url_launcher.dart';

import '../mydrawer.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  int pageIndex = 0;
  List<String> pname = ["ગાય ","ભેંસ"];
  List<String> mno = ["9067127486","7096750532"];
  List<String> loc = ["Surat","Bhanvnahar"];
  List<String> cname = ["Dharmik","Manhar"];
  List<String> photo = ["assets/images/photo1.png",
                        "assets/images/photo2.png"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(string.appName),
          backgroundColor: myColors.colorPrimaryColor,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        ),
        drawer: mydrawer(),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: pname.length,
              padding: ob50,
              itemBuilder: (context, index) {
                return MyCard(pname[index],mno[index],loc[index],cname[index],photo[index]);
              }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: bottonbar(context),);
  }
}

Widget bottonbar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FloatingActionButton.extended(
      backgroundColor: myColors.colorPrimaryColor,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => TakeScreen(),
        );
      },
      isExtended: true,
      icon: Icon(Icons.add),
      label: Text("પોસ્ટ કરો"),
    ),
  );
}


Widget MyCard(String name, String mno, String loc, String cname, String photo) {
  return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Ink.image(
                    height: 200,
                    image: AssetImage(photo),
                    width:400,
                    fit: BoxFit.fitWidth,
                  ),
                  Positioned(
                      top: 2,
                      right: 5,
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ))
                ],
              ),
              Padding(
                  padding: ah10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: ah10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text("વેચનાર નું નામ : $cname"),
                            Text("પ્રાણી : $name",),
                            Text("ગામ : $loc",),
                            Text("મોબાઈલ નંબર  : $mno",)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: myColors.colorPrimaryColor,
                                  ),
                                  onPressed: () async {
                                    final phoneurl='tel:+91$mno';
                                    if (await canLaunch(phoneurl))
                                    {
                                      await launch(phoneurl);
                                    }else {
                                      throw 'Could not launch $phoneurl';
                                    }
                                  },
                                  child: Icon(Icons.call)),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: myColors.colorPrimaryColor,
                                  ),
                                  onPressed: () async {
                                    final wsurl='https://wa.me/+91$mno?text=$name';
                                    if (await canLaunch(wsurl))
                                    {
                                      await launch(wsurl);
                                    }else{
                                      throw "Not work";
                                    }
                                  },
                                  child: Ink.image(
                                      height: 30,
                                      width: 30,
                                      image: AssetImage(Images.wsLogo))),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          )));
}
