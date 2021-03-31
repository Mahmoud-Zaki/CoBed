import 'package:google_maps_flutter/google_maps_flutter.dart';

class Hospital {
  String userName='';
  String city='';
  String orgName;
  String orgImg;
  String orgPhoneNumber;
  LatLng orgLocation;
  int totalBeds;
  int totalCoronaBeds;
  int availableCoronaBeds;
  int availableBeds;

  Hospital({
    this.userName,this.availableBeds,this.availableCoronaBeds,
    this.city,this.orgLocation,this.orgImg,this.orgName,
    this.totalCoronaBeds,this.orgPhoneNumber,this.totalBeds,
  });
}