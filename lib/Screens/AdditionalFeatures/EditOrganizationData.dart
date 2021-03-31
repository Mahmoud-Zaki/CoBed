import 'dart:io';
import 'package:cobed/Componants/DisplayPostContainer.dart';
import 'package:cobed/Componants/OrgEditContainer.dart';
import 'package:cobed/Componants/SmallButton.dart';
import 'package:cobed/Provider/EditOrganization.dart';
import 'package:cobed/Provider/LoadingAndScrolling.dart';
import 'package:cobed/Provider/OrgAuth.dart';
import 'package:cobed/Provider/PostNotifier.dart';
import 'package:cobed/Screens/Authentication/ChooseAccount.dart';
import 'package:cobed/Screens/Map/Map.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditOrganizationData extends StatefulWidget{
  @override
  EditOrganizationDataState createState() => EditOrganizationDataState();
}

class EditOrganizationDataState extends State<EditOrganizationData> {

  @override
  void initState() {
    super.initState();
    Provider.of<EditOrganization>(context,listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    var edit = Provider.of<EditOrganization>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          backgroundColor: Constants.WhiteColor,
          shape: ContinuousRectangleBorder(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(80.0),
              bottomRight: Radius.circular(80.0),
            ),
          ),
          title: General.buildTxt(
              txt: 'Edit organization data',
              color: Constants.GrayDarkColor,
              fontSize: 25),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Constants.GrayDarkColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 6.4,
        ),
        body: Consumer<EditOrganization>(
          builder: (context, hospital, child) =>
          (hospital.latLng == null) ?
          General.customLoading(color: Constants.OrangeColor,isCircle: true)
          : ListView(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,
            ),
            children: [
              Selector<PostNotifier, File>(
                selector: (context, img) => img.getImg,
                builder: (context, post, child) => OrgEditContainer(
                  type: 'post',
                  width: MediaQuery.of(context).size.width * 0.9,
                  postImg: post,
                  function1: Provider.of<PostNotifier>(context,listen: false).setNullImg,
                  function2: Provider.of<PostNotifier>(context,listen: false).getImgFromDevice,
                ),
              ),
              Selector<EditOrganization, int>(
                selector: (context, beds) => beds.getTotalBeds,
                builder: (context, bedNumber, child) =>
                    OrgEditContainer(
                  txt: 'السرائر الكلية',
                  type: 'edit',
                  width: MediaQuery.of(context).size.width * 0.9,
                  number: bedNumber,
                  function1: edit.decTotalBeds,
                  function2: edit.incTotalBeds,
                ),
              ),
              Selector<EditOrganization, int>(
                selector: (context, beds) => beds.getTotalCoronaBeds,
                builder: (context, bedNumber, child) =>
                    OrgEditContainer(
                  txt: 'السرائر المخصصة لكرونا',
                  type: 'edit',
                  width: MediaQuery.of(context).size.width * 0.9,
                  number: bedNumber,
                  function1: edit.decTotalCoronaBeds,
                  function2: edit.incTotalCoronaBeds,
                ),
              ),
              Selector<EditOrganization, int>(
                selector: (context, beds) => beds.getAvailableCoronaBeds,
                builder: (context, bedNumber, child) =>
                    OrgEditContainer(
                  txt: 'سرائر كرونا المتاحة',
                  type: 'edit',
                  width: MediaQuery.of(context).size.width * 0.9,
                  number: bedNumber,
                  function1: edit.decAvailableCoronaBeds,
                  function2: edit.incAvailableCoronaBeds,
                ),
              ),
              Selector<EditOrganization, int>(
                selector: (context, beds) => beds.getAvailableBeds,
                builder: (context, bedNumber, child) =>
                    OrgEditContainer(
                  txt: 'سرائر العناية المركزة المتاحة',
                  type: 'edit',
                  width: MediaQuery.of(context).size.width * 0.9,
                  number: bedNumber,
                  function1: edit.decAvailableBeds,
                  function2: edit.incAvailableBeds,
                ),
              ),
              General.sizeBoxVerical(30.0,),
              Row(
                children: [
                  General.buildTxt(txt: 'Submit your Location', fontSize: 20.0),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Constants.GrayLightColor.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Constants.CommonColor,
                      ),
                      child: Center(
                          child: Icon(
                        Icons.location_on,
                        color: Constants.OrangeColor,
                        size: 40.0,
                      )),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapView(
                            user: false,initialMarker: true,
                            initialLatLng: edit.latLng,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              General.sizeBoxVerical(30.0),
              Row(
                children: [
                  General.sizeBoxHorizontial(
                      MediaQuery.of(context).size.width * 0.1),
                  General.buildTxt(
                      txt: '        Edit\norganization\n        pic',
                      fontSize: 20.0),
                  General.sizeBoxHorizontial(
                      MediaQuery.of(context).size.width * 0.05),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Constants.WhiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Constants.GrayLightColor.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Constants.WhiteColor,
                        radius: 46.0,
                        foregroundColor: Constants.GrayLightColor,
                        child: Selector<EditOrganization, File>(
                          selector: (context, org) => org.getImg,
                          builder: (context, img, child) =>
                          (img==null)? Image.asset(
                              'Assets/organization.png',
                              color: Constants.OrangeColor,
                              width: 50.0,
                              height: 50.0,
                            ) : Image.file(img),
                        ),
                      ),
                    ),
                    onTap: edit.getImgFromDevice,
                  ),
                ],
              ),
              General.sizeBoxVerical(MediaQuery.of(context).size.height*0.02),
              (hospital.posts.isNotEmpty) ?
              Divider(color: Constants.GrayColor) : SizedBox(),
              General.sizeBoxVerical(MediaQuery.of(context).size.height*0.01),
              (hospital.posts.isNotEmpty) ?
              General.buildTxt(txt: 'Latest Updates',fontSize: 20.0)
                  : SizedBox(),
              (hospital.posts.isNotEmpty) ?
              General.sizeBoxVerical(MediaQuery.of(context).size.height*0.025)
                  : SizedBox(),
              ListView.builder(
                  itemCount: hospital.posts.length,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Color background,titleColor;
                    if(index % 2 == 0) {
                      background = Constants.CommonColor;
                      titleColor = Constants.OrangeColor;
                    } else {
                      background = Constants.BlueLightColor;
                      titleColor = Constants.BlueColor;
                    }
                    return DisplayPostContainer(
                      title: hospital.posts[index].title,txt: hospital.posts[index].caption,
                      img: hospital.posts[index].img, backGroundColor: background,
                      width: MediaQuery.of(context).size.width, color: titleColor,
                      height: MediaQuery.of(context).size.height,edit: true,
                      deleteFunction: (){
                        General.buildDialog(
                          context: context, title: 'Deleting',txt: 'Delete',isEdit: true,
                          content: General.buildTxt(txt: 'Are you sure to delete this?',fontSize: 18.0),
                          color: Constants.RedColor,function: ()async{
                            bool result = await Provider.of<PostNotifier>(context,listen: false)
                              .deletePost(id: hospital.posts[index].id);
                            if(result)
                              hospital.deletePost(index: index);
                          }
                        );
                      }, editFunction: (){_modalBottomSheetMenu(id:hospital.posts[index].id);}
                    );
                  }
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height * 0.088,
          color: Constants.WhiteColor,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SmallButton(
                  height: MediaQuery.of(context).size.height * 0.07,shadow: true,
                  color: Constants.TobyColor, txt: 'Log out',txtColor: Constants.WhiteColor,
                  function: () async{
                    bool logOut = await Provider.of<OrgAuth>(context,listen: false).orgLogOut();
                    if(logOut)
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChooseAccount(),
                        ),
                        (route) => false,
                      );
                  },
                ),
              ),
              General.sizeBoxHorizontial(6.4),
              Expanded(
                flex: 1,
                child: Consumer<LoadingAndScrolling>(
                  builder: (context, load, child) =>
                    SmallButton(
                      height: MediaQuery.of(context).size.height * 0.07,shadow: true,
                      color: Constants.GrayLightColor, txt: 'Submit',txtColor: Constants.BlackColor,
                      isLoading: load.load,function: _submit,
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit()async{
    Provider.of<LoadingAndScrolling>(context,listen: false).startLoading();
    var edit = Provider.of<EditOrganization>(context,listen: false);
    bool submit = await edit.submit();
    bool addPost = await Provider.of<PostNotifier>(context,listen: false)
        .addPost();
    if(addPost)
      edit.getData();
    Provider.of<LoadingAndScrolling>(context,listen: false).stopLoading();
    General.buildDialog(
      context: context, title: (submit&&addPost)?'succeeded!':'Failed!',
      color: (submit&&addPost)?Constants.BlackColor:Constants.RedColor,
      content: (submit&&addPost)? SizedBox() :
      General.buildTxt(
        txt: 'Something wrong, Try again',fontSize: 18.0,
      ),
    );
  }

  void _modalBottomSheetMenu({String id}){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (builder) =>
        Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              children: [
                OrgEditContainer(
                  type: 'post',isEdit: true,
                  width: MediaQuery.of(context).size.width * 0.9,
                  postImg: Provider.of<PostNotifier>(context,listen: false).img,
                  function1: Provider.of<PostNotifier>(context,listen: false).setNullImg,
                  function2: Provider.of<PostNotifier>(context,listen: false).getImgFromDevice,
                ),
                General.sizeBoxVerical(16.0),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SmallButton(
                        height: MediaQuery.of(context).size.height * 0.07,shadow: true,
                        color: Constants.GrayLightColor, txt: 'Cancel',txtColor: Constants.WhiteColor,
                        function: () {Navigator.of(context).pop();},
                      ),
                    ),
                    General.sizeBoxHorizontial(6.4),
                    Expanded(
                      flex: 1,
                      child: Consumer<LoadingAndScrolling>(
                        builder: (context, load, child) =>
                          SmallButton(
                            height: MediaQuery.of(context).size.height * 0.07,shadow: true,
                            color: Constants.TobyColor, txt: 'Save',txtColor: Constants.BlackColor,
                            isLoading: load.load,function: ()async{
                              load.startLoading();
                              bool result = await Provider.of<PostNotifier>(context,listen: false)
                                  .editPost(id: id);
                              if(result)
                                Provider.of<EditOrganization>(context,listen: false).getData();
                              load.stopLoading();
                              Navigator.of(context).pop();
                            },
                          ),
                      ),
                    ),
                  ],
                ),
                General.sizeBoxVerical(16.0),
              ],
            ),
          ),
        ),
    );
  }
}