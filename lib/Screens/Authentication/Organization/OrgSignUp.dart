import 'package:cobed/Componants/CustomFormField.dart';
import 'package:cobed/Componants/DropDown.dart';
import 'package:cobed/Componants/LargeButton.dart';
import 'package:cobed/Provider/OrgAuth.dart';
import 'package:cobed/Screens/Map/Map.dart';
import 'package:cobed/Services/PositionOnMap.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class OrgSignUp extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.01),
                Row(
                  children: [
                    General.sizeBoxHorizontial(
                      MediaQuery.of(context).size.width * 0.025,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        if(!Provider.of<OrgAuth>(context,listen: false).loading)
                          Navigator.of(context).pop();
                      },
                      color: Constants.GrayDarkColor,
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.015),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.017),
                  child: Column(
                    children: [
                      ClipRRect(child: Image.asset('Assets/co-bed-logo.png',
                        width: MediaQuery.of(context).size.width*0.66,),
                      ),
                      General.buildTxt(txt: 'Sign up to continue',
                          color: Constants.GrayDarkColor,isBold: false,fontSize: 18)
                    ],
                  ),
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.05),
                CustomFormField(
                  width: MediaQuery.of(context).size.width,number: false,pass: false,
                  hintText: 'Enter user name',cursorColor:Constants.CommonColor,
                  map: false, function: (String input){
                    Provider.of<OrgAuth>(context,listen: false).setUserName(newName: input);
                  },multilinePost: false,titlePost: false,done: false,
                  valid: (String input) {
                    Pattern pattern =
                        r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(input))
                      return '    Invalid username';
                    else
                      return null;
                  },
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.01),
                CustomFormField(
                  width: MediaQuery.of(context).size.width,number: false,pass: false,
                  hintText: 'Enter hospital name',cursorColor:Constants.CommonColor,
                  map: false, function: (String input){
                    Provider.of<OrgAuth>(context,listen: false).setOrgName(newName: input);
                  },multilinePost: false,titlePost: false,done: false,
                  valid: (String input) {
                    if(input.trim()=='')
                      return '    Invalid name';
                    else
                      return null;
                  },
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.01),
                CustomFormField(
                  width: MediaQuery.of(context).size.width,number: true,pass: false,
                  hintText: 'Enter hospital phone number',cursorColor:Constants.CommonColor,
                  map: false, function: (String input){
                    Provider.of<OrgAuth>(context,listen: false).setOrgPhoneNumber(newPhone: input);
                  },multilinePost: false,titlePost: false,done: false,
                  valid: (String input) {
                    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    RegExp regExp = new RegExp(pattern);
                    if (input.length == 0) {
                      return '    Invalid phone number';
                    }
                    else if (!regExp.hasMatch(input)) {
                      return '    Invalid phone number';
                    }
                    return null;
                  }
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.01),
                CustomFormField(
                  width: MediaQuery.of(context).size.width,number: false,pass: true,
                  hintText: 'Enter password',cursorColor:Constants.CommonColor,map: false,
                  function: (String input){
                    Provider.of<OrgAuth>(context,listen: false).setOrgPassword(pass: input);
                  },multilinePost: false,titlePost: false,done: false,
                  valid: (String input){
                    Pattern pattern =
                        r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(input))
                      return '    Invalid password';
                    else
                      return null;
                  }
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.01),
                ContainerDropDown(isUser: false,),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.01),
                Row(
                  children: [
                    General.sizeBoxHorizontial(MediaQuery.of(context).size.width*0.05),
                    General.buildTxt(txt: 'Total beds number', fontSize: 20.0),
                    Expanded(child: SizedBox()),
                    CustomFormField(
                      width: MediaQuery.of(context).size.width*0.35,number: true,
                      hintText: '',cursorColor:Constants.CommonColor, pass: false,
                      map: false, function: (String input){
                        final int beds = int.tryParse(input);
                        Provider.of<OrgAuth>(context,listen: false).setOrgTotalBeds(beds: beds);
                      },multilinePost: false,titlePost: false,done: false,
                      valid: (String input){
                        final int beds = int.tryParse(input);
                        if (beds == null)
                          return '    Invalid';
                        else
                          return null;
                      },
                    ),
                  ],
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.01),
                Row(
                  children: [
                    General.sizeBoxHorizontial(MediaQuery.of(context).size.width*0.05),
                    General.buildTxt(txt: 'Covid-19 beds number', fontSize: 20.0),
                    Expanded(child: SizedBox()),
                    CustomFormField(
                      width: MediaQuery.of(context).size.width * 0.35,number: true,
                      hintText: '',cursorColor:Constants.CommonColor,pass: false,
                      map: false, function: (String input){
                        final int beds = int.tryParse(input);
                        Provider.of<OrgAuth>(context,listen: false).setOrgTotalCoronaBeds(beds: beds);
                      },multilinePost: false,titlePost: false,
                      valid: (String input){
                        final int beds = int.tryParse(input);
                        if (beds == null)
                          return '    Invalid';
                        else
                          return null;
                      },
                    ),
                  ],
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.01),
                Row(
                  children: [
                    General.sizeBoxHorizontial(MediaQuery.of(context).size.width*0.05),
                    General.buildTxt(txt: 'Submit your Location', fontSize: 20.0),
                    Expanded(child: SizedBox()),
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Constants.GrayLightColor.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Constants.CommonColor,
                        ),
                        child: Center(
                            child: Icon(
                              Icons.location_on,
                              color: Constants.OrangeColor,
                              size: 40.0,
                            )),
                      ),
                      onTap: () async{
                        LatLng location = await PositionOnMap.getCurrentPosition();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapView(
                              user: false,initialMarker: false,
                              initialLatLng: location,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.05),
                Consumer<OrgAuth>(
                  builder: (context,auth,child) =>
                    LargeButton(
                      height: MediaQuery.of(context).size.height,load: auth.loading,call: false,
                      width: MediaQuery.of(context).size.width,changeColorIcon: false,
                      color: Constants.CommonColor,txtColor: Constants.GrayDarkColor,
                      prefixIcon: false,shadow: false,txtBold: false,txt: 'Sign up',
                      function: () async{
                        print(auth.orgLocation.latitude);
                        if(_formKey.currentState.validate() &&
                            auth.orgLocation != null && auth.loading == false) {
                          _formKey.currentState.save();
                          String result = await auth.orgSignUp();
                          General.buildDialog(
                            context: context,title: (result == 'done')?'succeeded!':'Failed!',
                            color: (result == 'done')?Constants.GreenColor:Constants.RedColor,
                            content: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: General.buildTxt(
                                txt: (result == 'done')?'Your account will be activated soon'
                                    : result,fontSize: 18.0,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}