import 'package:cobed/Componants/CustomFormField.dart';
import 'package:cobed/Componants/SmallButton.dart';
import 'package:cobed/Provider/EditOrganization.dart';
import 'package:cobed/Provider/MapNotifier.dart';
import 'package:cobed/Provider/OrgAuth.dart';
import 'package:cobed/Services/PositionOnMap.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  final LatLng initialLatLng;
  final bool user, initialMarker;
  MapView({this.initialLatLng,this.user,this.initialMarker});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  LatLng latLng;
  GoogleMapController mapController;

  void _cameraControl({LatLng newLatLng}) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: newLatLng,
          zoom: 18.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<MapNotifier>(context,listen: false)
        .clearMarkers();
    if(widget.user||widget.initialMarker)
      Provider.of<MapNotifier>(context,listen: false)
          .setInitialMarker(latLng: widget.initialLatLng);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Consumer<MapNotifier>(
              builder:  (context, mapNotifier, child) =>
              GoogleMap(
                initialCameraPosition: CameraPosition(target: widget.initialLatLng,zoom: 18.0),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                markers: mapNotifier.markers != null ? Set<Marker>.from(mapNotifier.markers) : null,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                onCameraMove: (CameraPosition newPosition) {
                  latLng = newPosition.target;
                },
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*0.02,
              child: CustomFormField(
                width: MediaQuery.of(context).size.width, number: false, pass: false,
                cursorColor: Constants.OrangeColor, hintText: 'Search', map: true,
                function: (String input) async{
                  LatLng location = await PositionOnMap.getCoordinates(address: input);
                  _cameraControl(newLatLng: location);
                },multilinePost: false,titlePost: false,
                valid: (String input){
                  if (input.trim() == '')
                    return 'Invalid';
                  else
                    return null;
                },
              )
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              top: 0.0,
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.location_on,
                  color: Constants.BlueDarkColor,
                  size: 50.0,
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height*0.016,
              left: MediaQuery.of(context).size.width*0.02,
              child: SmallButton(
                txt: (widget.user)?"Add marker":'  Done  ',color: Constants.TobyColor,
                height: MediaQuery.of(context).size.height * 0.06,shadow: false,
                txtColor: Constants.WhiteColor,function: (){
                  if(widget.user)
                    Provider.of<MapNotifier>(context,listen: false).setMarker(latLng: latLng);
                  else if(!widget.initialMarker) {
                    Provider.of<OrgAuth>(context,listen: false)
                        .setOrgLocation(latLng: latLng);
                    Navigator.of(context).pop();
                  } else {
                    Provider.of<EditOrganization>(context,listen: false)
                        .setLatLng(location: latLng??widget.initialLatLng);
                    Navigator.of(context).pop();}
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.CommonColor,
          child: Icon(Icons.my_location),
          onPressed: () async{
            LatLng location = await PositionOnMap.getCurrentPosition();
            _cameraControl(newLatLng: location);
          },
        ),
      ),
    );
  }
}