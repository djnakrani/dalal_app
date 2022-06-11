import 'package:dalal_app/constants/imports.dart';

class string{
  static const appName = "દલાલ";
}

class LocateString extends Translations
{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'appTitle': 'Dalal',
      'mobileNo': 'Mobile Number',
      'next': 'Submit',
      'otpsend': 'Otp Sended',
      'otpresend': 'Resent Otp'
    },
    'hi_IN':{
      'appTitle': 'दलाल',
      'mobileNo': 'मोबाइल नंबर',
      'next': 'आगे बढ़ो',
      'otpsend': 'Otp भेज दिया',
      'otpresend': 'पुनः भेजें'

    },
    'gu_IN':{
      'appTitle' : 'દલાલ',
      'mobileNo': 'મોબાઈલ નંબર',
      'next': 'આગળ વધો',
      'otpsend': 'Otp મોકલેલ ',
      'otpresend': 'ફરીથી મોકલો '

    }

  };
}