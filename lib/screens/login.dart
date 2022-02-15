import 'package:flutter/material.dart';
import 'package:dalal_app/constants/myColors.dart';
import 'package:get/get.dart';

import '../constants/Images.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}


class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            // decoration: new BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage("Images/bg.jpg"), fit: BoxFit.fill)),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(maxHeight: 200),
                            margin: const EdgeInsets.only(top: 120),
                            child: Image.asset(Images.logoImage),
                          ),
                        ),
                      ),
                      // Container(
                      //     margin: const EdgeInsets.only(top: 10),
                      //     child: const Text('મહિલા કિસાન એપ',
                      //         style: TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 50,
                      //             fontWeight: FontWeight.w800)))
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              filled: true,
                              prefixIcon: const Icon(
                                Icons.email,
                                color: myColors.colorPrimaryColor,
                              ),
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "તમારું ઈ-મેલ નાખો....",
                              fillColor: Colors.white70),
                          onChanged: (value) {
                            // phoneNumber = value;
                          },
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              filled: true,
                              prefixIcon: const Icon(
                                Icons.password,
                                color: myColors.colorPrimaryColor,
                              ),
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "તમારો પાસવર્ડ નાંખો...",
                              fillColor: Colors.white70),
                          onChanged: (value) {
                            // phoneNumber = value;
                          },
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          alignment: Alignment.topRight,
                          child: MaterialButton(
                            child: const Text(
                              "પાસવર્ડ ભુલાઈ ગયો?",
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {},
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          // constraints: const BoxConstraints(maxWidth: 500),
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  primary: myColors.colorPrimaryColor),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Text(
                                      'આગળ વધો',
                                      style:
                                      TextStyle(color: Colors.white),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: myColors.colorPrimaryColor,
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: MaterialButton(
                            child: const Text(
                              "નવું એકાઉન્ટ બનાવો?",
                              style: TextStyle(color: myColors.colorPrimaryColor),
                            ),
                            onPressed: () {

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => login()));

                            },
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}