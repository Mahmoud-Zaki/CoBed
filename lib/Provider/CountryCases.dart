import 'package:cobed/Models/Country.dart';
import 'package:cobed/Services/API.dart';
import 'package:flutter/foundation.dart';

class CountryCases extends ChangeNotifier {
  List<Country> countries=[];
  Country currentCountry;
  Country egypt;
  bool smallSizeLine = false;

  void countriesList() async {
    final response =await API().coronaCases();
    List data = response;
    for (int i = 0; i < data.length; i++) {
      if (data[i]['country'] == 'Egypt') {
        currentCountry= Country(
          countryName: data[i]['country'].toString(),
          countryFlag: data[i]['countryInfo']['flag'].toString(),
          cases: data[i]['cases'],
          todayCases: data[i]['todayCases'],
          deaths: data[i]['deaths'],
          todayDeaths: data[i]['todayDeaths'],
          recovered: data[i]['recovered'],
        );
        egypt=currentCountry;
      } else {
        countries.add(Country(
          countryName: data[i]['country'].toString(),
          countryFlag: data[i]['countryInfo']['flag'].toString(),
          cases: data[i]['cases'],
          todayCases: data[i]['todayCases'],
          deaths: data[i]['deaths'],
          todayDeaths: data[i]['todayDeaths'],
          recovered: data[i]['recovered'],
        ));
      }
    }
    notifyListeners();
  }

  void setCurrentCountry({Country current}) {
    currentCountry = current;
    if(current.cases.toString().length>6||current.todayCases.toString().length>4)
      smallSizeLine=true;
    notifyListeners();
  }
}