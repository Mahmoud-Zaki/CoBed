import 'package:cobed/Componants/SmallContainer.dart';
import 'package:cobed/Provider/Auth.dart';
import 'package:cobed/Screens/Authentication/Organization/OrgLogin.dart';
import 'package:cobed/Screens/Authentication/User/UserSignUp.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.1,
              bottom: MediaQuery.of(context).size.height * 0.1),
          child: ListView(
            children: [
              ClipRRect(
                child: Image.asset(
                  'Assets/co-bed-logo.png',
                ),
              ),
              General.sizeBoxVerical(MediaQuery.of(context).size.height * 0.06),
              General.buildTxt(
                txt: 'Choose the\ntype of\nyour\naccount',
                fontSize: 40.0,
              ),
              General.sizeBoxVerical(MediaQuery.of(context).size.height * 0.06),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Consumer<Auth>(
                      builder: (context, changeAccount, child) =>
                          GestureDetector(
                        child: SmallContainer(
                          backGroundColor: (!changeAccount.org)
                              ? Constants.CommonColor
                              : Constants.WhiteColor,
                          txt: 'User',isCases: false,
                          img: 'Assets/user.png',
                          color: Constants.GrayDarkColor,
                        ),
                        onTap: () {
                          changeAccount.typeOfAccount(isOrg: false);
                        },
                      ),
                    ),
                  ),
                  General.sizeBoxHorizontial(
                      MediaQuery.of(context).size.width * 0.05),
                  Expanded(
                    flex: 1,
                    child: Consumer<Auth>(
                      builder: (context, changeAccount, child) =>
                          GestureDetector(
                        child: SmallContainer(
                          backGroundColor: (!changeAccount.org)
                              ? Constants.WhiteColor
                              : Constants.CommonColor,
                          txt: 'Organization',
                          img: 'Assets/organization.png',isCases: false,
                          color: Constants.GrayDarkColor,
                        ),
                        onTap: () {
                          changeAccount.typeOfAccount(isOrg: true);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: GestureDetector(
          child: CircleAvatar(
            radius: 35.0,
            child: Icon(
              Icons.arrow_forward,
              color: Constants.GrayColor,
              size: 40.0,
            ),
            backgroundColor: Constants.CommonColor,
          ),
          onTap: () {
            bool user = Provider.of<Auth>(context,listen: false).org;
            (!user) ?
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserSignUp(),
              ),
            ) :
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrgLogin(),
              ),
            );
          },
        ),
      ),
    );
  }
}