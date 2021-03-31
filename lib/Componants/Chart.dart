import 'package:cobed/Models/Chart.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:cobed/Provider/CountryCases.dart';

class Charts extends StatelessWidget {
  final String country;
  Charts({this.country});
  bool _same = true;

  List<charts.Series<Chart, String>> createData(context) {
    var country = Provider.of<CountryCases>(context,listen: true);
    bool same = (country.egypt==country.currentCountry)?true:false;
    _same = same;
    final egyptCases = [
      Chart(type: 'Infiction', numbers: country.egypt.cases),
      Chart(type: 'Deaths', numbers: country.egypt.deaths),
      Chart(type: 'Recovered', numbers: country.egypt.recovered),
    ];
    final otherCountryCases = [
      Chart(type: 'Infiction', numbers: (same) ? 0 : country.currentCountry.cases),
      Chart(type: 'Deaths', numbers: (same) ? 0 : country.currentCountry.deaths),
      Chart(type: 'Recovered', numbers: (same) ? 0 : country.currentCountry.recovered),
    ];

    return [
      charts.Series<Chart, String>(
        id: 'Cases',
        domainFn: (Chart cases, _) => cases.type,
        measureFn: (Chart cases, _) => cases.numbers,
        data: egyptCases,
        fillColorFn: (Chart cases, _) {
          return charts.MaterialPalette.deepOrange.shadeDefault;
        },
      ),
      charts.Series<Chart, String>(
        id: 'Cases',
        domainFn: (Chart cases, _) => cases.type,
        measureFn: (Chart cases, _) => cases.numbers,
        data: otherCountryCases,
        fillColorFn: (Chart cases, _) {
          return charts.MaterialPalette.blue.shadeDefault;
        },
      ),
    ];
  }

  barChart(context) {
    return charts.BarChart(
      createData(context),
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.only(
          top: 20.0,
          bottom: 20.0,
          right: MediaQuery.of(context).size.width * 0.025,
          left: MediaQuery.of(context).size.width * 0.025),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            color: Constants.GrayLightColor.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Constants.WhiteColor,
      ),
      child: Column(
        children: [
          General.buildTxt(txt: 'Cases graph',color: Constants.GrayLightColor,fontSize: 18),
          General.sizeBoxVerical(5.0),
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            color: Constants.WhiteColor,
            child: barChart(context),
          ),
          General.sizeBoxVerical(5.0),
          Row(
            children: [
              CircleAvatar(radius: 6,backgroundColor: Constants.OrangeColor,),
              General.sizeBoxHorizontial(6.0),
              General.buildTxt(txt: 'Egypt',fontSize: 18,isBold: false),
              General.sizeBoxHorizontial(MediaQuery.of(context).size.width*0.05),
              (!_same)?CircleAvatar(radius:6,backgroundColor:Constants.BlueColor):General.sizeBoxHorizontial(1.0),
              General.sizeBoxHorizontial(6.0),
              (!_same)?General.buildTxt(txt: country,fontSize: 18,isBold: false):General.sizeBoxHorizontial(1.0),
            ],
          ),
        ],
      ),
    );
  }
}