import 'dart:io';
import 'package:cobed/Componants/CustomFormField.dart';
import 'package:cobed/Provider/PostNotifier.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgEditContainer extends StatelessWidget{
  final String txt, type;
  final File postImg;
  final Function function1, function2;
  final int number;
  final double width;
  final bool isEdit;

  OrgEditContainer({@required this.txt,@required this.type,@required this.width,
    @required this.function2,this.number,this.function1,this.postImg,this.isEdit=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0,bottom: 20.0,left: width*0.0559,right: width*0.0559),
      margin: const EdgeInsets.only(top: 30.0),
      width: width,
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
      child: (type == 'post')?
      Column(
        children: [
          Row(
            children: [
              (isEdit)?Icon(Icons.edit,size: 30.0,):Icon(Icons.add,size: 30.0,),
              General.sizeBoxHorizontial(5.0),
              General.buildTxt(txt: (isEdit)?'EDIT POST':'ADD POST',fontSize: 20.0,),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                (postImg == null) ? SizedBox() :
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Constants.WhiteColor,
                        ),
                        child: Image.file(postImg),
                      ),
                      Positioned(
                        top: 0, left: 0,
                        child: IconButton(
                          icon: Icon(Icons.close),color: Constants.WhiteColor,
                          onPressed: function1,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      CustomFormField(
                        titlePost: true,number: false,pass: false,map: false,
                        cursorColor: Constants.GrayLightColor,multilinePost: false,
                        hintText: 'Title',valid: (){},width: MediaQuery.of(context).size.width*0.35,
                        function: (String input){
                          Provider.of<PostNotifier>(context,listen: false).setPostTitle(postTitle: input);
                        },done: false,
                      ),
                      General.sizeBoxVerical(10.0),
                      CustomFormField(
                        titlePost: false,number: false,pass: false,map: false,
                        cursorColor: Constants.GrayLightColor,multilinePost: true,
                        hintText: 'Description',valid: (){},width: MediaQuery.of(context).size.width*0.35,
                        function: (String input){
                          Provider.of<PostNotifier>(context,listen: false).setPostCaption(postCaption: input);
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              CircleAvatar(child: IconButton(
                icon: Icon(CupertinoIcons.photo,color: Constants.BlackColor,size: 35.0,),
                onPressed: function2,
              ),
                backgroundColor: Constants.ScaffoldColor,radius: 28.0,),
            ],
          )
        ],
      )
      : Column(
        children: [
          General.buildTxt(txt: txt,englishLanguage: false,fontSize: 20.0),
          General.sizeBoxVerical(15.0),
          Row(
            children: [
              General.sizeBoxHorizontial(width*0.22),
              CircleAvatar(backgroundColor: Constants.ScaffoldColor,child: IconButton(
                icon: Icon(CupertinoIcons.minus,color: Constants.BlackColor),
                onPressed: function1,
              ),),
              General.sizeBoxHorizontial(width*0.025),
              Container(
                width: width*0.2,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Constants.ScaffoldColor
                ),
                child: Center(child:General.buildTxt(txt: number.toString(),)),
              ),
              General.sizeBoxHorizontial(width*0.025),
              CircleAvatar(backgroundColor: Constants.ScaffoldColor,child: IconButton(
                icon: Icon(CupertinoIcons.add,color: Constants.BlackColor,),
                onPressed: function2,
              ),),
            ],
          ),
        ],
      ),
    );
  }
}