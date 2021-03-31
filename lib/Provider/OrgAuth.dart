import 'dart:convert';
import 'package:cobed/Models/Hospital.dart';
import 'package:cobed/Models/User.dart';
import 'package:cobed/Services/API.dart';
import 'package:cobed/Services/SharedPreferences.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrgAuth extends ChangeNotifier {
  bool loading = false;
  String userName;
  String password;
  String orgName;
  String orgPhone;
  String orgCity;
  LatLng orgLocation;
  int totalBeds;
  int totalCoronaBeds;

  void setLoading({bool load}) {
    loading = load;
    notifyListeners();
  }

  void setUserName({String newName}) {
    userName = newName.trim();
  }

  void setCity({String newCity}) {
    orgCity = newCity;
  }

  void setOrgName({String newName}) {
    orgName = newName.trim();
  }

  void setOrgPassword({String pass}) {
    password = pass;
  }

  void setOrgPhoneNumber({String newPhone}) {
    orgPhone = newPhone;
  }

  void setOrgLocation({LatLng latLng}) {
    orgLocation = latLng;
  }

  void setOrgTotalBeds({int beds}) {
    totalBeds = beds;
  }

  void setOrgTotalCoronaBeds({int beds}) {
    totalCoronaBeds = beds;
  }

  Future<String> orgSignUp() async{
    loading = true;
    notifyListeners();

    Hospital hospital = Hospital(
      city: orgCity,
      orgName: orgName,
      userName: userName,
      orgLocation: orgLocation,
      orgPhoneNumber: orgPhone,
      totalBeds: totalBeds,
      totalCoronaBeds: totalCoronaBeds,
      availableBeds: totalBeds-totalCoronaBeds,
      availableCoronaBeds: totalCoronaBeds,
    );

    String result = await API().register(hospital: hospital, password: password);
    loading = false;
    notifyListeners();
    return result;
  }

  Future<String> orgLogIn() async{
    loading = true;
    notifyListeners();
    String response = await API().login(userName: userName, password: password);
    if(response == 'Unauthorized'){
      loading = false;
      notifyListeners();
      return 'User name not found';
    }
    final result = jsonDecode(response);
    if(result['message'] == 'Your account has not accepted yet'){
      loading = false;
      notifyListeners();
      return 'Your account has not been activated yet';
    } else {
      User user = User(name: userName,city: result['user'][0]['city'],accessToken: result['token'],id: result['user'][0]['_id']);
      bool done = await SharedPreferenceHandler.setUserData(user);
      if(done) {
        loading = false;
        notifyListeners();
        return 'true';
      }
    }
  }

  Future<bool> orgLogOut() async{
    bool result = await SharedPreferenceHandler.removeUserData();
    return result;
  }
}