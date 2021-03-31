import 'package:cached_network_image/cached_network_image.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';

class DisplayPostContainer extends StatelessWidget{
  final String title, txt, img;
  final Color backGroundColor, color;
  final double width, height;
  final bool edit;
  final Function editFunction,deleteFunction;

  DisplayPostContainer({this.title,this.txt,this.img,this.color,this.edit=false,
  @required this.backGroundColor,@required this.width,@required this.height,
  this.deleteFunction,this.editFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical:  (edit)?height*0.01:height*0.02,
        horizontal: width*0.02,
      ),
      padding: const EdgeInsets.all(16.0),
      width: width*0.8,
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
        color: backGroundColor,
      ),
      child: Column(
        children: [
          (title==null)?SizedBox():General.buildTxt(
              txt: title,englishLanguage: false,color: color,fontSize: 20.0),
          (title==null)?General.sizeBoxVerical(6.0):General.sizeBoxVerical(10.0),
          (img!=null&&txt!=null)?Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.network(
                    Constants.baseURL + img,
                    loadingBuilder: (context,child,progress) => (progress == null)? child :
                    General.customLoading(color: Constants.WhiteColor),
                    errorBuilder: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              General.sizeBoxHorizontial(20.0),
              Expanded(
                flex: 1,
                child: General.buildTxt(
                    txt: txt,fontSize: 20,color: Constants.GrayDarkColor,englishLanguage: false),
              ),
            ],
          ) :
          Center(
            child: (img==null) ?
            (txt==null)?SizedBox():General.buildTxt(
                txt: txt,fontSize: 20,color: Constants.GrayDarkColor,englishLanguage: false)
                : ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
              Constants.baseURL + img,
              loadingBuilder: (context,child,progress) => (progress == null)? child :
              General.customLoading(color: Constants.WhiteColor),
              errorBuilder: (context, url, error) => Icon(Icons.error),
            ),
                ),
          ),
          (!edit)?General.sizeBoxVerical(0.0):
            Row(
              textDirection: TextDirection.ltr,
              children: [
                CircleAvatar(
                  radius: 16.0,
                  backgroundColor: Constants.WhiteColor,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.delete,color: Constants.GrayDarkColor,size: 20),
                    onPressed: deleteFunction,
                  ),
                ),
                General.sizeBoxHorizontial(width*0.02),
                CircleAvatar(
                  radius: 16.0,
                  backgroundColor: Constants.WhiteColor,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.edit,color: Constants.GrayDarkColor,size: 20),
                    onPressed: editFunction,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}