import 'package:cobed/Componants/CustomFormField.dart';
import 'package:cobed/Componants/LargeButton.dart';
import 'package:cobed/Provider/OrgAuth.dart';
import 'package:cobed/Screens/Authentication/Organization/OrgSignUp.dart';
import 'package:cobed/Screens/Home.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgLogin extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<OrgAuth>(context,listen: false);
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
                        if(!auth.loading)
                          Navigator.of(context).pop();
                      },
                      color: Constants.GrayDarkColor,
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.175),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.017),
                  child: Column(
                    children: [
                      ClipRRect(child: Image.asset('Assets/co-bed-logo.png',
                        width: MediaQuery.of(context).size.width*0.66,),
                      ),
                      General.buildTxt(txt: 'Login to continue',
                          color: Constants.GrayDarkColor,isBold: false,fontSize: 18)
                    ],
                  ),
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.07),
                CustomFormField(
                  width: MediaQuery.of(context).size.width,number: false, pass: false,
                  hintText: 'Enter user name',cursorColor:Constants.OrangeColor,
                  map: false,titlePost:false,multilinePost:false,function:(String input){
                    Provider.of<OrgAuth>(context,listen: false).setUserName(newName: input);
                  },done: false,
                  valid: (String input) {
                    Pattern pattern =
                        r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(input))
                      return '    Invalid username';
                    else
                      return null;
                  },
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.015),
                CustomFormField(
                  width: MediaQuery.of(context).size.width,number: false,pass: true,
                  hintText: 'Enter your Password',cursorColor:Constants.OrangeColor,
                  map: false,titlePost:false,multilinePost:false,function: (String input){
                  Provider.of<OrgAuth>(context,listen: false).setOrgPassword(pass: input);
                  },
                  valid: (String input){
                    Pattern pattern =
                        r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(input))
                      return '    Invalid password';
                    else
                      return null;
                  }
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.07),
                Consumer<OrgAuth>(
                  builder: (context,login,child) =>
                      LargeButton(
                        height: MediaQuery.of(context).size.height,call: false,load: login.loading,
                        width: MediaQuery.of(context).size.width,changeColorIcon: true,
                        color: Constants.OrangeColor,txtColor: Constants.WhiteColor,
                        prefixIcon: false,shadow: false,txtBold: false,txt: 'Login',
                        function: () async{
                          if(_formKey.currentState.validate() && login.loading == false) {
                            _formKey.currentState.save();
                            String result = await login.orgLogIn();
                            if(result == 'true') {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Home(isUser: false,name: auth.userName),
                                ),
                                    (route) => false,
                              );
                            } else {
                              General.buildDialog(
                                context: context,title: 'Failed!',
                                color: Constants.RedColor,
                                content: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: General.buildTxt(
                                    txt: result,fontSize: 18.0,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),
                ),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.01),
                General.buildTxt(txt: 'Don\'t have organization account',
                    color: Constants.GrayColor,fontSize: 18,isBold: false),
                General.sizeBoxVerical(MediaQuery.of(context).size.height*0.015),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.3),
                  child: InkWell(
                    child: General.buildTxt(txt: 'Sign up',
                        color: Constants.OrangeColor,fontSize: 18),
                    onTap: (){
                      if(!auth.loading)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrgSignUp(),
                          ),
                        );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}