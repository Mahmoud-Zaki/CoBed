import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';

class LargeContainer extends StatelessWidget{
  final String txt, img, imgDirection;
  final double width;
  final Color backGroundColor, color;

  LargeContainer({@required this.backGroundColor,@required this.color,@required this.width,
     @required this.txt,@required this.img,@required this.imgDirection});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width*0.1,
        vertical: 30.0,
      ),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: backGroundColor,
      ),
      child: (imgDirection == 'center') ?
      Center(
        child: Column(
          children: [
            ClipRRect(child: Image.asset(img,color: color,width: 70.0,height: 70.0,),),
            General.sizeBoxVerical(7.0),
            General.buildTxt(txt: txt,fontSize: 20,color: color),
          ],
        ),
      )
          : Row(
        children: [
          Flexible(
            child: (imgDirection == 'right')?
            General.buildTxt(txt: txt,fontSize: 20,color: color)
                : ClipRRect(child: Image.asset(img,color: color,),),
          ),
          Expanded(child: SizedBox()),
          Flexible(
            child: (imgDirection == 'right')?
            ClipRRect(child: Image.asset(img,color: color,),)
                : General.buildTxt(txt: txt,fontSize: 20,color: color),
          ),
        ],
      ),
    );
  }
}