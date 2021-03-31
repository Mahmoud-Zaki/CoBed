import 'package:cobed/Componants/LargeContainer.dart';
import 'package:cobed/Componants/SmallContainer.dart';
import 'package:cobed/Screens/AdditionalFeatures/CoronaTest.dart';
import 'package:cobed/Screens/AdditionalFeatures/EditOrganizationData.dart';
import 'package:cobed/Screens/AdditionalFeatures/NumberOfCases.dart';
import 'package:cobed/Screens/AdditionalFeatures/PreventiveMeasures.dart';
import 'package:cobed/Screens/MainFeatures/Search.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final bool isUser;
  final String name;
  Home({@required this.isUser,@required this.name});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                General.sizeBoxVerical(
                    MediaQuery.of(context).size.height * 0.36),
                Positioned(
                  top: MediaQuery.of(context).size.width * 0.667 * -0.25,
                  left: MediaQuery.of(context).size.width * 0.667 * -0.15,
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.667 * 0.58,
                    backgroundColor: Constants.OrangeColor,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.667 * 0.05,
                      ),
                      child: General.buildTxt(
                          txt: 'Hello\n $name',
                          fontSize: 40,
                          color: Constants.WhiteColor),
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.46,
                  top: MediaQuery.of(context).size.height * 0.03,
                  child: Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Constants.WhiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Constants.GrayLightColor.withOpacity(0.5),
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        General.buildTxt(
                          txt: General.getDate(),
                          fontSize: 18,
                        ),
                        General.sizeBoxHorizontial(5.0),
                        Icon(
                          CupertinoIcons.calendar,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.133,
                  child: Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      color: Constants.WhiteColor,
                      borderRadius: BorderRadius.circular(100.0),
                      boxShadow: [
                        BoxShadow(
                          color: Constants.GrayLightColor.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        child: Image.asset(
                          (isUser)
                              ? 'Assets/user.png'
                              : 'Assets/organization.png',
                          color: Constants.OrangeColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.25,
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15.0, right: 15.0, left: 20.0),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Constants.WhiteColor,
                        borderRadius: BorderRadius.circular(50.0),
                        boxShadow: [
                          BoxShadow(
                            color: Constants.GrayLightColor.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: General.buildTxt(
                                txt: 'Search near hospitals',
                                color: Constants.GrayLightColor,
                                isBold: false,
                                fontSize: 20.0),
                          ),
                          General.sizeBoxHorizontial(10.0),
                          Icon(CupertinoIcons.search),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          SearchHospital(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.05),
              decoration: BoxDecoration(
                color: Constants.WhiteColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50.0),
                  topLeft: Radius.circular(50.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Constants.GrayLightColor.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  (isUser)
                      ? GestureDetector(
                          child: LargeContainer(
                            backGroundColor: Constants.BlueLightColor,
                            imgDirection: 'left',
                            txt: 'Corona\n   test',
                            img: 'Assets/test.png',
                            color: Constants.BlueColor,
                            width: MediaQuery.of(context).size.width * 0.9,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CoronaTest(),
                              ),
                            );
                          },
                        )
                      : Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                child: SmallContainer(
                                  backGroundColor: Constants.BlueLightColor,
                                  txt: 'Corona\n   test',isCases: false,
                                  img: 'Assets/test.png',
                                  color: Constants.BlueColor,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CoronaTest(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            General.sizeBoxHorizontial(20.0),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                child: SmallContainer(
                                  backGroundColor: Constants.CommonColor,
                                  txt: 'Preventive\nmeasures',
                                  img: 'Assets/mask.png',isCases: false,
                                  color: Constants.OrangeColor,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PreventiveMeasures(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                  General.sizeBoxVerical(15.0),
                  GestureDetector(
                    child: LargeContainer(
                      backGroundColor: (isUser)
                          ? Constants.CommonColor
                          : Constants.GreenLightColor,
                      imgDirection: (isUser) ? 'center' : 'right',
                      txt: (isUser)
                          ? 'Preventive\nmeasures'
                          : 'Number\n    of\n cases',
                      img: (isUser) ? 'Assets/mask.png' : 'Assets/graph.png',
                      color: (isUser)
                          ? Constants.OrangeColor
                          : Constants.GreenColor,
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              (isUser) ? PreventiveMeasures() : Cases(),
                        ),
                      );
                    },
                  ),
                  General.sizeBoxVerical(15.0),
                  GestureDetector(
                    child: LargeContainer(
                      backGroundColor: (isUser)
                          ? Constants.GreenLightColor
                          : Constants.PurpleLightColor,
                      imgDirection: (isUser) ? 'right' : 'left',
                      txt: (isUser)
                          ? 'Number\n    of\n cases'
                          : '   Edit\nhospital\n   data',
                      img: (isUser) ? 'Assets/graph.png' : 'Assets/edit.png',
                      color: (isUser)
                          ? Constants.GreenColor
                          : Constants.PurpleColor,
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              (isUser) ? Cases() : EditOrganizationData(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}