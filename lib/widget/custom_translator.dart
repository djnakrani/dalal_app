import 'package:dalal_app/constants/imports.dart';
import 'package:translator/translator.dart';

translatorString(trans) {
  var translator = GoogleTranslator();
  translator.translate(trans, from: 'auto', to: 'gu').then((value) {
    Get.log(value.toString());
    return value.toString();
  });
}
