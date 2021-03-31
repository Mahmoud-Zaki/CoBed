import 'package:flutter/material.dart';

class Constants {
  static const String coronaApiURL =
      'https://disease.sh/v2/countries?yesterday=false&sort=cases';

  static const String baseURL = 'https://cobeds.herokuapp.com/';

  static const List<String> citiesOfEgypt = [
    'Cairo','Giza','Qalyubia','Helwan','6th of October','Beheira','Marsa Matruh',
    'Dakahlia','Kafr El Sheikh','Gharbia','Monufia','Damietta','Port Said',
    'Ismailia','Suez','Sharqia','North of Sinai','South of Sinai','Fayoum',
    'Beni Suef','Minya','Asyut','New Valley','Sohag','Qena','Luxor','Aswan','Red Sea',
  ];

  static const List<String> testQuestions = [
    'كم عمرك؟',
    'هل تدخن؟',
    'هل كان لديك اختلاط وثيق بحالة مؤكدة؟',
    'هل كان لديك اختلاط وثيق بحالة مشبوهة؟',
    'هل عانيت من الحمى(فوق 38 درجة مئوية)؟',
    'هل تعاني من السعال الجاف(الكحة الناشفة)؟',
    'هل تعاني من الإجهاد أو آلام العضلات أو المفاصل أو الشعور بضغط على الصدر؟',
    'هل عانيت من فقدان حاسة الشم أو التذوق أو كلايهما؟',
    'هل تعاني من احتقان الأنف أو إحمرار العين أو انعدام الشهية؟',
    'هل تعاني من الرشح؟',
    'هل تعاني من الإسهال و/أو القئ؟',
    'هل تعاني من الصداع المستمر؟',
    'هل تعاني من ضيق في التنفس؟',
    'هل تعاني من ألم في الحلق؟'
  ];

  static const Color ScaffoldColor = Color(0xfff2f1f7);
  static const Color WhiteColor = Colors.white;
  static const Color BlackColor = Colors.black;
  static const Color CommonColor = Color(0xfffedbca);
  static const Color GrayDarkColor = Color(0xff77706D);
  static const Color GrayColor = Color(0xff848282);
  static const Color GrayLightColor = Color(0xffBCBDCE);
  static const Color OrangeColor = Color(0xffFE805A);
  static const Color TobyColor = Color(0xffD66060);
  static const Color BlueDarkColor = Color(0xff49648A);
  static const Color BlueColor = Color(0xff2491E4);
  static const Color BlueLightColor = Color(0xffCBE5F9);
  static const Color GreenDarkColor = Color(0xff709D83);
  static const Color GreenLightColor = Color(0xffACF6D1);
  static const Color GreenColor = Color(0xff38BC5B);
  static const Color GreenHalfColor = Color(0xfd19C572);
  static const Color PurpleLightColor = Color(0xffF7CCDE);
  static const Color PurpleColor = Color(0xffBF6B8D);
  static const Color PurpleHalfColor = Color(0xffCD7B96);
  static const Color RedColor = Color(0xffBF1313);
}