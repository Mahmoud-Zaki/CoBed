import 'package:cobed/Models/User.dart';
import 'package:cobed/Provider/Auth.dart';
import 'package:cobed/Provider/SearchNotifier.dart';
import 'package:cobed/Provider/OrgAuth.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerDropDown extends StatefulWidget{
  final bool isSearch;
  final bool isUser;

  ContainerDropDown({this.isSearch=false,this.isUser=true});

  @override
  ContainerDropDownState createState() => ContainerDropDownState();
}

class ContainerDropDownState extends State<ContainerDropDown>{
  String _txt = 'Cairo';

  @override
  void initState() {
    super.initState();
    if(widget.isSearch)
      _getCity();
  }

  void _getCity() async{
    User user = await Provider.of<Auth>(context,listen: false).getUserData();
    setState(() {
      _txt = user.city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: Constants.WhiteColor,
        boxShadow: (widget.isSearch) ? [
          BoxShadow(
            color: Constants.GrayLightColor.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]: [],
      ),
      width: MediaQuery.of(context).size.width*0.9,
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width*0.05,
        right: MediaQuery.of(context).size.width*0.05,
      ),
      padding: EdgeInsets.only(right: 20.0,top: 10.0,bottom: 10.0,
          left: MediaQuery.of(context).size.width*0.1),
      child: DropdownButton<String>(
        value: _txt,
        onChanged: (String newValue){
          setState(() {
            _txt=newValue;
          });
          if(widget.isSearch)
            Provider.of<SearchNotifier>(context,listen: false).getOrganizations(city: newValue);
          else if(widget.isUser)
            Provider.of<Auth>(context,listen: false).setCity(newCity: newValue);
          else
            Provider.of<OrgAuth>(context,listen: false).setCity(newCity: newValue);
        },
        isDense: true,
        selectedItemBuilder: (BuildContext context) {
          return Constants.citiesOfEgypt.map<Widget>((_) {
            return Align(
              alignment: (widget.isSearch) ? Alignment.centerLeft : Alignment.center,
              child: General.buildTxt(
                txt: _txt, fontSize: 25.0,
                color: Constants.GrayLightColor,isBold: false,
              ),
            );
          }).toList();
        },
        underline: SizedBox(),
        items: Constants.citiesOfEgypt.map((city){
          return DropdownMenuItem<String>(
            value: city,
            child: General.buildTxt(txt: city,isBold: false),
          );
        }).toList(),
        icon: (widget.isSearch) ?
        Container() :
        CircleAvatar(
          child: Icon(Icons.keyboard_arrow_down,size: 40,
            color: Constants.BlackColor,),
          backgroundColor: Constants.ScaffoldColor,
        ),
        iconSize: 40,
        isExpanded: true,
      ),
    );
  }
}