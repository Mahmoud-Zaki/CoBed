import 'package:cobed/Componants/SmallContainer.dart';
import 'package:cobed/Provider/CountryCases.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:cobed/Componants/Chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cases extends StatefulWidget {
  @override
  CasesState createState() => CasesState();
}

class CasesState extends State<Cases> {
  @override
  void initState() {
    super.initState();
    Provider.of<CountryCases>(context,listen: false).countriesList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<CountryCases>(
          builder: (context, country, child) =>
            (country.countries == null || country.egypt == null) ?
            General.customLoading(color: Constants.OrangeColor, isCircle: true)
            : ListView(
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
                  General.sizeBoxHorizontial(
                    MediaQuery.of(context).size.width * 0.2,
                  ),
                  Expanded(
                    child: General.buildTxt(
                           txt: country.currentCountry.countryName,
                           fontSize: 30.0,
                           isBold: false),
                  ),
                ],
              ),
              General.sizeBoxVerical(20.0),
              Row(
                children: [
                  General.sizeBoxHorizontial(
                      MediaQuery.of(context).size.width * 0.05),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: General.buildTxt(
                              txt: 'Infictions', fontSize: 25.0, isBold: false),
                        ),
                        Row(
                            children: [
                              Column(
                                children: [
                                  General.sizeBoxVerical(10.0),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: General.buildTxt(
                                          txt: country
                                              .currentCountry
                                              .cases
                                              .toString(),
                                          color: Constants.BlueColor,
                                          fontSize:(country.smallSizeLine)?20.0:28.0)
                                  ),
                                ],
                              ),
                              (country.currentCountry.todayCases == 0)?
                              SizedBox() : Icon(
                                Icons.arrow_upward,
                                color: Constants.GreenHalfColor,
                                size: 18,
                              ),
                              (country.currentCountry.todayCases == 0)?
                              SizedBox() : Align(
                                alignment: Alignment.topLeft,
                                child: General.buildTxt(
                                  txt: country
                                      .currentCountry
                                      .todayCases
                                      .toString(),
                                  color: Constants.GreenHalfColor,
                                  fontSize: (country.smallSizeLine)?12.0:18.0,
                                ),
                              ),
                            ],
                        ),
                        Align(
                        alignment: Alignment.topLeft,
                          child: General.buildTxt(
                              txt: 'Total cases', fontSize: 25.0, isBold: false),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: General.buildTxt(
                              txt: 'Deaths', fontSize: 25.0, isBold: false),
                        ),
                        Row(
                            children: [
                              Column(
                                children: [
                                  General.sizeBoxVerical(10.0),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: General.buildTxt(
                                          txt: country
                                              .currentCountry
                                              .deaths
                                              .toString(),
                                          color: Constants.OrangeColor,
                                          fontSize: (country.smallSizeLine)?20.0:28.0),
                                    ),
                                  ],
                                ),
                              (country.currentCountry.todayDeaths == 0)?
                              SizedBox() : Icon(
                                  Icons.arrow_downward,
                                  color: Constants.RedColor,
                                  size: 18,
                                ),
                              (country.currentCountry.todayDeaths == 0)?
                                  SizedBox() : Align(
                                  alignment: Alignment.topLeft,
                                  child: General.buildTxt(
                                    txt: country
                                        .currentCountry
                                        .todayDeaths
                                        .toString(),
                                    color: Constants.RedColor,
                                    fontSize: (country.smallSizeLine)?12.0:18.0,
                                  ),
                                ),
                              ],
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: General.buildTxt(
                              txt: 'Total deaths', fontSize: 25.0, isBold: false),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Charts(
                country: country.currentCountry.countryName,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.025,
                ),
                child: General.buildTxt(
                  txt: 'Top Countries',
                  fontSize: 25,
                ),
              ),
              General.sizeBoxVerical(15.0),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02,
                ),
                height: MediaQuery.of(context).size.height * 0.264,
                color: Constants.ScaffoldColor,
                child: ListView.builder(
                    itemCount: country.countries.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      Color color;
                      if (index % 3 == 0) {
                        color = Constants.BlueDarkColor;
                      } else if (index % 2 == 0) {
                        color = Constants.GreenDarkColor;
                      } else {
                        color = Constants.PurpleHalfColor;
                      }
                      return GestureDetector(
                        child: SmallContainer(
                          isCases: true,
                          backGroundColor: color,
                          txt: country.countries[index].countryName,
                          img: country.countries[index].countryFlag,
                          number: country.countries[index].cases,
                          eNumber: country.egypt.cases,
                        ),
                        onTap: (){
                          country.setCurrentCountry(
                            current: country.countries[index],
                          );
                        },
                      );
                    },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}