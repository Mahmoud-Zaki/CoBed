import 'package:flutter/foundation.dart';

class LoadingAndScrolling extends ChangeNotifier{
  bool load = false;
  bool longestContainer = false;

  void startLoading(){
    load = true;
    notifyListeners();
  }

  void stopLoading(){
    load = false;
    notifyListeners();
  }

  void lengtheningContainer({bool lengthening}){
    longestContainer = lengthening;
    notifyListeners();
  }
}