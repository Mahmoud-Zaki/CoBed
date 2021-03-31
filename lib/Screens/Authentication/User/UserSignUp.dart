import 'package:cobed/Componants/CustomFormField.dart';
import 'package:cobed/Componants/DropDown.dart';
import 'package:cobed/Componants/LargeButton.dart';
import 'package:cobed/Provider/Auth.dart';
import 'package:cobed/Screens/Home.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSignUp extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.025),
                Row(
                  children: [
                    General.sizeBoxHorizontial(
                      MediaQuery.of(context).size.width * 0.025,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Constants.GrayDarkColor,
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.175),
                Stack(
                  children: [
                    ClipRRect(child: Image.asset('Assets/welcome.png',
                      color: Constants.GrayColor,
                      width: MediaQuery.of(context).size.width,
                    ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height*0.038,
                      left: MediaQuery.of(context).size.width*0.16,
                      child: Column(
                        children: [
                          ClipRRect(child: Image.asset('Assets/co-bed-logo.png',
                            width: MediaQuery.of(context).size.width*0.66,),
                          ),
                          General.buildTxt(txt: 'Sign up to continue',
                              color: Constants.GrayDarkColor,isBold: false,fontSize: 18)
                        ],
                      ),
                    ),
                  ],
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.07),
                CustomFormField(
                  width: MediaQuery.of(context).size.width,number: false,pass: false,
                  hintText: 'Enter your name',cursorColor:Constants.CommonColor,
                  map: false,function: (String input){
                    Provider.of<Auth>(context,listen: false).setName(newName: input);
                  },multilinePost: false,titlePost: false,
                  valid: (String input) {
                    if(input.trim()=='')
                      return '    Invalid name';
                    else
                      return null;
                  },
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.015),
                ContainerDropDown(),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.07),
                LargeButton(
                  height: MediaQuery.of(context).size.height,call: false,load: false,
                  width: MediaQuery.of(context).size.width,changeColorIcon: false,
                  color: Constants.CommonColor,txtColor: Constants.GrayDarkColor,
                  prefixIcon: false,shadow: false,txtBold: false,txt: 'Sign up',
                  function: () async{
                    if(_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      var auth = Provider.of<Auth>(context,listen: false);
                      bool isDone = await auth.userSignUp();
                      if(isDone)
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(isUser: true,name: auth.name),
                          ),
                          (route) => false,
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}