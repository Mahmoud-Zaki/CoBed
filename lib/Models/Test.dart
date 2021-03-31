import 'package:cobed/Utils/Constants.dart';

class Test {

  static List<int> points = [0];

  static void setPoints(int point) {
    points.add(point);
  }

  static void removePoints() {
    points.removeLast();
  }

  static void removeAllPoints() {
    points.clear();
    print('list=$points');
  }

  static String getQuestion(int index) {
    return Constants.testQuestions.elementAt(index);
  }

  static String getStatus() {
    int total = 0;
    for (int i = 0; i < points.length; i++) {
      total += points[i];
    }
    if ((total == 2 && points[0] == 1)) return 'لا تقلق، ستكون بخير قريباً';
    if (total <= 2)
      return 'أجب على الأسئلة';
    else if (total < 5)
      return 'لا تقلق، ستكون بخير قريباً';
    else if (total <= 7)
      return 'لا تقلق، ستكون بخير قريباً\nوإذا أردت الآطمئنان أكثر قم بزيارة الطبيب';
    else if (total > 7)
      return 'لا تقلق، ستكون بخير قريباً\nكل ما عليك فعله هو الحفاظ على العزل المنزلي لمدة 14 يوم\nوإذا استمرت الأعراض أو شعرت بأعراض جديدة يستوجب عليك الذهاب إلى الرعاية الصحية';
  }
}