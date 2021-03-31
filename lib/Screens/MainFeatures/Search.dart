import 'package:cobed/Componants/DropDown.dart';
import 'package:cobed/Componants/ShadowContainer.dart';
import 'package:cobed/Provider/SearchNotifier.dart';
import 'package:cobed/Screens/MainFeatures/OrgPage.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchHospital extends StatefulWidget{
  @override
  SearchHospitalState createState() => SearchHospitalState();
}

class SearchHospitalState extends State<SearchHospital>{

  @override
  void initState() {
    super.initState();
    Provider.of<SearchNotifier>(context,listen: false).getOrganizations();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  General.sizeBoxHorizontial(
                    MediaQuery.of(context).size.width * 0.025,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Constants.GrayDarkColor,
                  ),
                ]
              ),
              General.sizeBoxVerical(10.0),
              ContainerDropDown(isSearch: true),
              General.sizeBoxVerical(MediaQuery.of(context).size.height*0.025),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
                  child: General.buildTxt(txt: 'Nearby Hospitals',fontSize: 27),
                ),
              ),
              General.sizeBoxVerical(MediaQuery.of(context).size.height*0.0125),
              Container(
                color: Constants.ScaffoldColor,
                child: Consumer<SearchNotifier>(
                  builder: (context, hospital, child) =>
                    (hospital.hospitals == null) ?
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.26),
                        child: General.customLoading(color: Constants.OrangeColor,isCircle: true),
                      )
                      : (hospital.hospitals.isEmpty) ?
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.26),
                          child: Column(
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                  'Assets/organization.png',
                                  color: Constants.OrangeColor,
                                  height: 52.0, width: 52.0,
                                ),
                              ),
                              General.sizeBoxVerical(6.0),
                              General.buildTxt(txt: 'There are no hospitals here',isBold: false,fontSize: 14.0,color: Constants.GrayColor)
                            ],
                          ),
                        )
                        : ListView.builder(
                          itemCount: hospital.hospitals.length,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return ShadowContainer(
                              imgDirection:'top',txt:hospital.hospitals[index]["name"],
                              height:MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width, img: hospital.hospitals[index]["image"],
                              function: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrgPage(
                                      id: hospital.hospitals[index]["_id"],
                                      img: hospital.hospitals[index]["image"],
                                      name: hospital.hospitals[index]["name"],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                      )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}