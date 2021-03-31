import 'package:cobed/Models/Post.dart';
import 'package:cobed/Models/User.dart';
import 'package:cobed/Services/API.dart';
import 'package:cobed/Services/SharedPreferences.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditOrganization extends ChangeNotifier {
  File img;
  int totalBeds;
  int totalCoronaBeds;
  int availableCoronaBeds;
  int availableBeds;
  LatLng latLng;
  List<Post> posts =[];

  File get getImg => img;
  int get getTotalBeds => totalBeds;
  int get getTotalCoronaBeds => totalCoronaBeds;
  int get getAvailableCoronaBeds => availableCoronaBeds;
  int get getAvailableBeds => availableBeds;

  void getData() async{
    if(posts.isNotEmpty)
      posts = [];
    User user = await SharedPreferenceHandler.getUserData();
    final response = await API().getOrganizationInfo(id: user.id);
    if(response != false){
      availableBeds = response["totalAvailableBeds"];
      availableCoronaBeds = response["coronaAvailableBeds"];
      totalCoronaBeds = response["coronaBeds"];
      totalBeds = response["totalBeds"];
      latLng = LatLng(response["coordinates"]["latitude"].toDouble(),
          response["coordinates"]["longitude"].toDouble());
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

  Future<bool> submit()async{
    Map<String,num> coordinates = {
      "latitude": latLng.latitude,
      "longitude": latLng.longitude
    };
    Map map = {
      "totalBeds":totalBeds,
      "coronaBeds":totalCoronaBeds,
      "totalAvailableBeds":availableBeds,
      "coronaAvailableBeds":availableCoronaBeds,
      "coordinates": coordinates
    };
    bool response=await API().editInfo(
      urlCompleter: 'users/update',image: img,body: map
    );
    img=null;
    notifyListeners();
    return response;
  }

  void deletePost({int index}){
    posts.removeAt(index);
    notifyListeners();
  }

  Future<void> getImgFromDevice() async {
    img = await ImagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  void setLatLng({LatLng location}) {
    latLng = location;
  }

  void incTotalBeds() {
    totalBeds++;
    notifyListeners();
  }

  void decTotalBeds() {
    if (totalBeds > 0) {
      totalBeds--;
      notifyListeners();
    }
  }

  void incTotalCoronaBeds() {
    totalCoronaBeds++;
    notifyListeners();
  }

  void decTotalCoronaBeds() {
    if (totalCoronaBeds > 0) {
      totalCoronaBeds--;
      notifyListeners();
    }
  }

  void incAvailableCoronaBeds() {
    availableCoronaBeds++;
    notifyListeners();
  }

  void decAvailableCoronaBeds() {
    if (availableCoronaBeds > 0) {
      availableCoronaBeds--;
      notifyListeners();
    }
  }

  void incAvailableBeds() {
    availableBeds++;
    notifyListeners();
  }

  void decAvailableBeds() {
    if (availableBeds > 0) {
      availableBeds--;
      notifyListeners();
    }
  }
}