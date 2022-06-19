import 'package:dalal_app/constants/imports.dart';

class CustomTextfield extends StatelessWidget {
  final String inputTxt;
  final TextInputType inputType;
  final int maxsize;
  final IconData myIcon;
  final Function(String)? voidReturn;
  final Function(String)? validationData;
  final bool obscureText;

  final int maxLine;
  const CustomTextfield({
    Key? key,
    required this.inputTxt,
    required this.inputType,
    required this.myIcon,
    this.obscureText = false,
    this.maxsize = 100,
    required this.voidReturn,
    this.maxLine = 1,
    required this.validationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: TextFormField(
        keyboardType: inputType,
        maxLength: maxsize,
        maxLines: maxLine,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: inputTxt,
          counterText: '',
          contentPadding: syv5,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:myColors.colorPrimaryColor),
            borderRadius: br20 /2 ,
          ),
          errorStyle: const TextStyle(fontSize: 0.01),
           errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: br20 / 2,
          ),
          prefixIcon: Icon(
            myIcon,
            color: myColors.colorPrimaryColor,
          ),
        ),
        validator: (value) {
          return validationData!(value!);
        },
        onChanged: (value) {
          voidReturn!(value);
        },
      ),
    );
  }
}
