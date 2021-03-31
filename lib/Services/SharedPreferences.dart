import 'package:cobed/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferenceHandler {
  static setUserData(User user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userData", json.encode(user.toMap()));
      return true;
    } catch (e) {
      print("set user sharedPreference error :${e.toString()}");
    }
    return false;
  }

  static getUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString('userData') != null) {
        Map<String, dynamic> data = json.decode(prefs.getString('userData'));
        User user = User.fromJson(data);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static removeUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("userData");
      return true;
    } catch (e) {
      print("set user sharedPreference error :${e.toString()}");
    }
    return false;
  }
}