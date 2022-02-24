import 'package:dalal_app/constants/Images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TakeScreen extends StatefulWidget {
  @override
  _TakeScreenState createState() => _TakeScreenState();
}

class _TakeScreenState extends State<TakeScreen> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
      // title: const Text('What You Add....'),
      child: Container(
          width: double.maxFinite,
          child:Column(
            children: [
              Container(child: Text('What You Add....')),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 15,padding: EdgeInsets.all(5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0
                  ),
                  itemBuilder: (BuildContext context, int index){
                    // return Image.network(images[index]);
                    return Container(

                      child: Image.asset(Images.logoImage),
                      // height: 100,
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
// children: List.generate(choices.length, (index) {
//   return Center(
//     child: SelectCard(choice: choices[index]),
//   );
// }
// )

// ),
//     actions: <Widget>[
//       Center(
//         child: MaterialButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           textColor: Theme.of(context).primaryColor,
//           child: const Text('Close'),
//         ),
//       ),
//     ],
//   );
// }

// Widget allcategory() {
//   return Row(
//         children: [
//           Text("Hello1"),
//           Text("Hello2")
//         ],
//       );
// }
// }
