import 'package:dalal_app/constants/imports.dart';
import 'package:dalal_app/screens/Input_screens/input_form.dart';
import 'package:dalal_app/screens/home_screens/userhelplineno.dart';

class TakeScreen extends StatefulWidget {
  const TakeScreen({Key? key}) : super(key: key);

  @override
  _TakeScreenState createState() => _TakeScreenState();
}

class _TakeScreenState extends State<TakeScreen> {
  final Stream<QuerySnapshot> data = FirebaseFirestore.instance
      .collection("Category")
      .orderBy("No")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: syh20v5 + syv40,
      child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: ah10,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const UserHelpLine());
                        },
                        style: ElevatedButton.styleFrom(
                            primary: myColors.colorPrimaryColor),
                        child: Row(
                          children: [
                            Image.asset(Images.logoImage,
                                height: 50.h, width: 50.w),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Padding(
                              padding: syv5,
                              child: Text(
                                "helpline".tr,
                                style: TextStyle(
                                    fontSize: 18.w, color: Colors.white),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: data,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return CustomText(text: "retry".tr);
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomText(text: "Wait....");
                      }
                      final category = snapshot.requireData;
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: category.size,
                        padding: const EdgeInsets.all(5),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              margin: ah10,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => InputForm(
                                        category: category.docs[index].id,
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.green,
                                    primary: Colors.white60),
                                child:
                                    Image.network(category.docs[index]['url']),
                              ));
                        },
                      );
                    }),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: CustomText(
                      text: 'exit'.tr,
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
