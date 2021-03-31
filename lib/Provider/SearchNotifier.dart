import 'package:cobed/Models/Hospital.dart';
import 'package:cobed/Models/Post.dart';
import 'package:cobed/Models/User.dart';
import 'package:cobed/Services/API.dart';
import 'package:cobed/Services/SharedPreferences.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchNotifier extends ChangeNotifier{
  List hospitals;
  Hospital hospitalInfo;
  List<Post> posts = [];

  void getOrganizations({String city}) async{
    if(city == null){
      User user = await SharedPreferenceHandler.getUserData();
      city = user.city;
    }
    if(hospitals != null) {
      hospitals = null;
      notifyListeners();
    }
    final response = await API().getAllOrganizations(city: city);
    if(response == false)
      hospitals = [];
    else
      hospitals = response;
    notifyListeners();
  }

  void getOrganizationInfo({String id}) async{
    if(hospitalInfo != null)
      hospitalInfo = null;
    if(posts.isNotEmpty)
      posts=[];
    final response = await API().getOrganizationInfo(id: id);
    if(response != false){
      hospitalInfo = Hospital(
        orgPhoneNumber: response["phoneNumber"],
        availableBeds: response["totalAvailableBeds"],
        availableCoronaBeds: response["coronaAvailableBeds"],
        totalCoronaBeds: response["coronaBeds"],
        totalBeds: response["totalBeds"],
        orgLocation: LatLng(response["coordinates"]["latitude"].toDouble(),
            response["coordinates"]["longitude"].toDouble())
      );
      List postsList = response["posts"];
      if(postsList.isNotEmpty){
        postsList.forEach((element) {
          posts.add(
            Post(
              caption: element["description"],
              img: element["image"],
              title: element["title"],
              id: element["_id"]
            )
          );
        });
      }
    }
    notifyListeners();
  }
}