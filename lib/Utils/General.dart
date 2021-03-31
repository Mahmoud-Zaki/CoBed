import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:flutter/material.dart';

class General {
  static sizeBoxHorizontial(space) {
    return SizedBox(
      width: space,
    );
  }

  static sizeBoxVerical(space) {
    return SizedBox(
      height: space,
    );
  }

  static buildTxt({@required String txt,
    Color color = Constants.BlackColor,
    double fontSize,
    bool isBold = true,
    bool englishLanguage = true}) {
    return Text(
      txt,
      textDirection: (englishLanguage)?TextDirection.ltr:TextDirection.rtl,
      style: TextStyle(
          color: color,
          fontFamily: "Montserrat",
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }

  static customLoading({@required Color color, bool isCircle = false}) {
    return Center(
      child: (isCircle) ? SpinKitCircle(
        color: color,
        size: 64.0,
      ) :
      SpinKitThreeBounce(
        color: color,
        size: 30.0,
      ),
    );
  }

  static buildDialog(
      {@required context,@required String title,@required Widget content,String txt = 'Save',
        Function function, bool isEdit = false, Color color}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
          title: buildTxt(txt: title,fontSize: 20.0, color: color),
          content: content,
          actions: (!isEdit) ?
          <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: buildTxt(txt: 'Cancel',fontSize: 18.0,color: Constants.TobyColor),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ]
              :
          <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: buildTxt(txt: 'Cancel',fontSize: 18.0,color: Constants.GrayDarkColor),
              onPressed: (){Navigator.of(context).pop();},
            ),
            CupertinoDialogAction(
              child: buildTxt(txt: txt,fontSize: 18.0,color: Constants.TobyColor),
              onPressed: (){function();Navigator.of(context).pop();},
            ),
          ]
      )
    );
  }

  static String getDate() {
    DateTime now = DateTime.now();
    String month;
    switch (now.month) {
      case 1:
        month = "January";
        break;
      case 2:
        month = "February";
        break;
      case 3:
        month = "March";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "August";
        break;
      case 9:
        month = "September";
        break;
      case 10:
        month = "October";
        break;
      case 11:
        month = "November";
        break;
      case 12:
        month = "December";
        break;
    }
    return now.day.toString() + ',' + month + ',' + now.year.toString();
  }
}