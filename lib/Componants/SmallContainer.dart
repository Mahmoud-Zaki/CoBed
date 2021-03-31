import 'package:cached_network_image/cached_network_image.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';

class SmallContainer extends StatelessWidget{
  final Color color, backGroundColor;
  final String txt, img;
  final int number, eNumber;
  final bool isCases;

  SmallContainer({@required this.txt,@required this.img,this.backGroundColor,this.color,
    this.number,this.eNumber,this.isCases});

  @override
  Widget build(BuildContext context) {
    if(isCases){
      return Container(
        padding: (eNumber>number)?const EdgeInsets.only(top: 0.0,bottom: 10.0):EdgeInsets.only(bottom: 0.0,top: 10.0),
        margin: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: backGroundColor,
        ),
        child: Stack(
          children: [
            ClipRRect(child: Image.asset((eNumber>number)?'Assets/arrow-down.png':
            'Assets/arrow-up.png',height: 200,width: 200,),),
            Positioned(
                left: (txt.length>=10)?5.0:30.0,
                top: 40.0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        General.buildTxt(txt: txt,fontSize:(txt.length>=12)?10:20,color: Constants.WhiteColor),
                        General.sizeBoxHorizontial(20.0),
                        Container(
                          height: 36.0,
                          width: 46.0,
                          padding: const EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(img),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    General.sizeBoxVerical(30.0),
                    General.buildTxt(txt: '$number',fontSize: 25,color: Constants.WhiteColor),
                  ],
                )
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: backGroundColor,
      ),
      child: Column(
        children: [
          General.sizeBoxVerical(30.0),
          ClipRRect(child: Image.asset(img,height: 60,width: 60,color: color,),),
          General.sizeBoxVerical(7.0),
          General.buildTxt(txt: txt,fontSize: 20,color: (txt == 'User')?Constants.BlackColor:color),
          General.sizeBoxVerical(30.0),
        ],
      ),
    );
  }
}