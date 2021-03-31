import 'package:cobed/Componants/LargeButton.dart';
import 'package:cobed/Models/Test.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CoronaTest extends StatefulWidget {
  @override
  CoronaTestState createState() => CoronaTestState();
}

class CoronaTestState extends State<CoronaTest> {
  double load = 0.0;
  int currentIndex = 0;
  int groupValue = 64;
  bool finish = false;

  void radioChange(int newValue) {
    setState(() {
      groupValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Constants.ScaffoldColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Constants.GrayColor,
                onPressed: () {
                  Test.removeAllPoints();
                  Navigator.of(context).pop();
                },
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.18,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Container(
                  color: Constants.ScaffoldColor,
                ),
                title: General.buildTxt(
                    txt: 'Corona\n   test',
                    fontSize: 25,
                    color: Constants.GrayDarkColor),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.05),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(color: Constants.BlackColor),
                      color: Constants.WhiteColor,
                    ),
                    child: LinearPercentIndicator(
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 864,
                      percent: load,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Constants.GreenHalfColor,
                      backgroundColor: Constants.WhiteColor,
                      isRTL: true,
                    ),
                  ),
                  General.sizeBoxVerical(20.0),
                  Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.025,
                        right: MediaQuery.of(context).size.width * 0.025,
                        top: MediaQuery.of(context).size.height * 0.025,
                        bottom: MediaQuery.of(context).size.height * 0.025),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(
                          color: Constants.GrayLightColor.withOpacity(0.10),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Constants.WhiteColor,
                    ),
                    child: (finish)
                        ? General.buildTxt(
                            txt: Test.getStatus(),
                            englishLanguage: false,
                            fontSize: 25.0,
                            color: Constants.OrangeColor)
                        : Column(
                            children: [
                              General.buildTxt(
                                  txt: Test.getQuestion(currentIndex),
                                  englishLanguage: false,
                                  fontSize: 25.0,
                                  color: Constants.OrangeColor),
                              General.sizeBoxVerical(15.0),
                              Row(
                                children: [
                                  Expanded(
                                      child: General.buildTxt(
                                    txt: (currentIndex == 0)
                                        ? 'أقل من 40'
                                        : 'نعم',
                                    color: Constants.GrayDarkColor,
                                    fontSize: 20.0,
                                    englishLanguage: false,
                                  )),
                                  Radio(
                                    value: 0,
                                    groupValue: groupValue,
                                    onChanged: radioChange,
                                    activeColor: Constants.GrayDarkColor,
                                  ),
                                ],
                              ),
                              General.sizeBoxVerical(7.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: General.buildTxt(
                                      txt: (currentIndex == 0)
                                          ? '40 أو أكثر'
                                          : 'لا',
                                      color: Constants.GrayDarkColor,
                                      fontSize: 20.0,
                                      englishLanguage: false,
                                    )
                                  ),
                                  Radio(
                                    value: 1,
                                    groupValue: groupValue,
                                    onChanged: radioChange,
                                    activeColor: Constants.GrayDarkColor,
                                  ),
                                ],
                              ),
                              General.sizeBoxVerical(7.0),
                            ],
                          ),
                  ),
                  General.sizeBoxVerical(20.0),
                  LargeButton(
                    height: MediaQuery.of(context).size.height,changeColorIcon: true,
                    width: MediaQuery.of(context).size.width,load: false,txtBold: true,
                    color: Constants.OrangeColor,txtColor: Constants.WhiteColor,call: false,
                    prefixIcon:false,shadow:true,txt:(currentIndex >= 13)?'Submit':'Forward',
                    function: () {
                      if (groupValue == 0 || groupValue == 1) {
                        if (currentIndex <= 13) {
                          if (currentIndex == 0 && groupValue == 1)
                            Test.setPoints(2);
                          else if (currentIndex == 0 && groupValue == 0)
                            Test.setPoints(1);
                          else if ((currentIndex == 2 || currentIndex == 3) &&
                              groupValue == 0)
                            Test.setPoints(10);
                          else if (groupValue == 0)
                            Test.setPoints(1);
                          else if (groupValue == 1) Test.setPoints(0);

                          setState(() {
                            load += 0.0715;
                            currentIndex++;
                            groupValue = 64;
                            if (load > 1.0) load = 1.0;
                            if (currentIndex > 13) finish = true;
                          });
                        }
                      }
                    },
                  ),
                  General.sizeBoxVerical(15.0),
                  LargeButton(
                    height: MediaQuery.of(context).size.height,changeColorIcon: false,
                    width: MediaQuery.of(context).size.width,load: false,txtBold: true,
                    color: Constants.GrayLightColor,txtColor: Constants.BlackColor,call: false,
                    prefixIcon:true,shadow:true,txt:(currentIndex > 13) ? 'Reset' : 'Back',
                    function: () {
                      if (currentIndex > 13) {
                        Test.removeAllPoints();
                        setState(() {
                          load = 0.0;
                          currentIndex = 0;
                          groupValue = 64;
                          finish = false;
                        });
                      } else if (currentIndex > 0) {
                        Test.removePoints();
                        setState(() {
                          load -= 0.0715;
                          currentIndex--;
                          groupValue = 64;
                          if (load < 0.0) load = 0.0;
                          if (currentIndex < 13) finish = false;
                        });
                      }
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}