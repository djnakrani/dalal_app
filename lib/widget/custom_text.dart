import 'package:dalal_app/constants/imports.dart';

double regularSize = 12;

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final TextDecoration textDecoration;
  const CustomText(
      {Key? key,
      required this.text,
      this.size = 12.0,
      this.fontWeight = FontWeight.normal,
      this.color = myColors.textColor,
      this.textDecoration = TextDecoration.none})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: size.sp,
          letterSpacing: 0.6,
          decoration: textDecoration),
    );
  }
}
