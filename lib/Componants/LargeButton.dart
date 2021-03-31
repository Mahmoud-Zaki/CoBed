import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget{
  final double height, width;
  final String txt;
  final Color color, txtColor;
  final Function function;
  final bool txtBold, shadow, changeColorIcon, load, call, prefixIcon;

  LargeButton({@required this.width,@required this.height,@required this.txt,
    @required this.color,@required this.txtColor,@required this.function,
    @required this.shadow,@required this.prefixIcon,this.call,this.load,
    this.changeColorIcon, this.txtBold});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height*0.02),
        margin: EdgeInsets.symmetric(horizontal: width*0.05),
        width: width*0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: (shadow)?[
            BoxShadow(
              color: Constants.GrayLightColor.withOpacity(0.10),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]:[],
          color: color,
        ),
        child: (load)?
        General.customLoading(color: Constants.WhiteColor)
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (prefixIcon)?
            Icon((call)?Icons.call:Icons.arrow_back,
              color: (call)?Constants.WhiteColor:Constants.GrayDarkColor,
            ) :
            General.buildTxt(txt:txt, fontSize: 25.0, color: txtColor,isBold: txtBold),
            General.sizeBoxHorizontial(10.0),
            (prefixIcon) ?
            General.buildTxt(txt:txt, fontSize: 25.0, color: txtColor,isBold: txtBold) :
            Icon(
              Icons.arrow_forward,
              color: (changeColorIcon)?Constants.WhiteColor:Constants.GrayDarkColor,
            ),
          ],
        ),
      ),
      onTap: function,
    );
  }
}