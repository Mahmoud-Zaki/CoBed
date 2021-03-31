import 'package:cached_network_image/cached_network_image.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget{
  final String imgDirection, txt, img;
  final double width, height;
  final Function function;

  ShadowContainer({@required this.txt,@required this.imgDirection,
    @required this.width,@required this.img,this.function,this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical:  (imgDirection=='top')?height*0.0125:0.0,
        horizontal: (imgDirection=='top')?width*0.05:0.0,
      ),
      padding: (imgDirection=='top') ?
      const EdgeInsets.all(10.0)
          : const EdgeInsets.all(30.0),
      width: width*0.9,
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
      child: (imgDirection=='top') ?
      Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              Constants.baseURL + img,
              errorBuilder: (context, url, error) => Icon(Icons.error),
              height: MediaQuery.of(context).size.height*0.16,
            ),
          ),
          General.sizeBoxVerical(20.0),
          General.buildTxt(txt: txt,fontSize: 20.0,),
          General.sizeBoxVerical(10.0),
          Row(
            children: [
              General.sizeBoxHorizontial(width*0.005),
              InkWell(
                child: General.buildTxt(txt: 'See more',fontSize: 18.0,color: Constants.BlueColor),
                onTap: function,
              ),
              Expanded(child: SizedBox(),),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios,color: Constants.BlackColor,size: 30.0,),
                onPressed: function,
              ),
            ],
          ),
        ],
      )
          : Row(
        children: [
          Expanded(
            flex: 1,
            child: (imgDirection=='right')?
            General.buildTxt(txt: txt,fontSize: 20,color: Constants.BlackColor,englishLanguage: false):
            ClipRRect(child: Image.asset(img),),
          ),
          General.sizeBoxHorizontial(20.0),
          Expanded(
            flex: 1,
            child: (imgDirection=='right')?
            ClipRRect(child: Image.asset(img),):
            General.buildTxt(txt: txt,fontSize: 20,color: Constants.BlackColor,englishLanguage: false),
          ),
        ],
      ),
    );
  }
}