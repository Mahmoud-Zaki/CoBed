import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget{
  final double height;
  final String txt;
  final Color color, txtColor;
  final Function function;
  final bool shadow, isLoading;

  SmallButton({@required this.height,@required this.txt,this.isLoading = false,
    @required this.color,@required this.txtColor,@required this.function,
    @required this.shadow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: height,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: (shadow)?[
            BoxShadow(
              color: Constants.GrayLightColor.withOpacity(0.5),
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]:[],
          color: color,
        ),
        child: (isLoading) ? General.customLoading(color: Constants.WhiteColor)
        : Center(
          child: General.buildTxt(
              txt: txt,
              color: txtColor,
              fontSize: 20.0),
        ),
      ),
      onTap: (isLoading)?(){}:function,
    );
  }
}