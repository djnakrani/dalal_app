import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:dalal_app/constants/style.dart';
import 'package:dalal_app/constants/string.dart';
import 'package:dalal_app/constants/Images.dart';

import '../mydrawer.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(string.appName),
          backgroundColor: myColors.colorPrimaryColor,
          actions: [IconButton(onPressed: (){}, icon: Icon(Icons.search))],
        ),

        drawer: mydrawer(),

        body: ListView.builder(
            itemCount: 5,
            padding: ob50,
            itemBuilder: (context, index) {
              return MyCard();
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: bottonbar());
  }
}

Widget bottonbar() {
  return  Container(
    height: 70.0,
    width: 70.0,
    child: FloatingActionButton(
      backgroundColor: myColors.colorPrimaryColor,
      onPressed: () {},
      child: Icon(Icons.add),
    ),
  );
}

Widget MyCard() {
  return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
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
                    image: AssetImage(Images.logoImage),
                    fit: BoxFit.fitWidth,
                  ),
                  Positioned(top: 2 ,right: 5,child: IconButton(icon: Icon(Icons.favorite,color: Colors.red,), onPressed: () {  },))
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
                          children: const [
                            Text(
                              "Owner Name : Manhar Dangar",
                            ),
                            Text(
                              "Item : Cow",
                            ),
                            Text(
                              "Location : Bhavnagar",
                            ),
                            Text(
                              "Number : 7096750532",
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: myColors.colorPrimaryColor,
                                  ),
                                  onPressed: () {}, child: Icon(Icons.call)),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: myColors.colorPrimaryColor,
                                  ),
                                  onPressed: () {},
                                  child:Ink.image(height:30,width: 30,image: AssetImage(Images.wsLogo)) ),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          )));
}
