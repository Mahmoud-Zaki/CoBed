import 'package:cobed/Models/User.dart';
import 'package:cobed/Services/SharedPreferences.dart';
import 'package:flutter/foundation.dart';

class Auth extends ChangeNotifier {

  bool org = true;
  String name='';
  String city='';

  void typeOfAccount({bool isOrg}) {
    org = isOrg;
    notifyListeners();
  }

  void setName({String newName}) {
    name = newName.trim();
  }

  void setCity({String newCity}) {
    city = newCity;
  }

  Future<bool> userSignUp() async {
    if(city=='')
      city='Cairo';
    User user = User(name: name,city: city,accessToken: '');
    bool result = await SharedPreferenceHandler.setUserData(user);
    return result;
  }

  Future<User> getUserData() async {
    User user = await SharedPreferenceHandler.getUserData();
    return user;
  }
}