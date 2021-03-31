import 'package:cached_network_image/cached_network_image.dart';
import 'package:cobed/Componants/DisplayPostContainer.dart';
import 'package:cobed/Componants/LargeButton.dart';
import 'package:cobed/Provider/LoadingAndScrolling.dart';
import 'package:cobed/Provider/SearchNotifier.dart';
import 'package:cobed/Screens/Map/Map.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrgPage extends StatefulWidget{
  final String id;
  final String img;
  final String name;
  OrgPage({this.id,this.img,this.name});

  @override
  OrgPageState createState() => OrgPageState();
}

class OrgPageState extends State<OrgPage>{
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<SearchNotifier>(context,listen: false).getOrganizationInfo(id: widget.id);
    controller.addListener(() {
      Provider.of<LoadingAndScrolling>(context,listen: false).lengtheningContainer(
        lengthening: controller.offset > 10
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //color: Constants.ScaffoldColor,
            ),
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height*0.23,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  Constants.baseURL + widget.img,
                  loadingBuilder: (context,child,progress) => (progress == null)? child :
                  General.customLoading(color: Constants.OrangeColor),
                  errorBuilder: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.01,
              left: MediaQuery.of(context).size.width * 0.025,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {Navigator.of(context).pop();},
                color: Constants.WhiteColor,
              ),
            ),
            Consumer<LoadingAndScrolling>(
              builder: (context, scroll, child) =>
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 264),
                  top: (scroll.longestContainer) ?
                      MediaQuery.of(context).size.height*0.14
                      : MediaQuery.of(context).size.height*0.22,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height*0.01,
                      horizontal: MediaQuery.of(context).size.width*0.05,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.77,
                    decoration: BoxDecoration(
                      color: Constants.ScaffoldColor,
                      borderRadius:BorderRadius.only(topLeft:Radius.circular(34.0),topRight:Radius.circular(34.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Constants.GrayLightColor.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Consumer<SearchNotifier>(
                      builder: (context, hospital, child) =>
                      (hospital.hospitalInfo == null) ?
                       Padding(
                         padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.06),
                         child: General.customLoading(color: Constants.OrangeColor,isCircle: true),
                       )
                       : ListView(
                        controller: controller,
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          children: [
                            General.sizeBoxVerical(MediaQuery.of(context).size.height*0.02),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.location_on,
                                    color: Constants.OrangeColor,
                                    size: 50.0,
                                  ),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MapView(
                                          user: true,
                                          initialLatLng: hospital.hospitalInfo.orgLocation,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Expanded(flex: 1,child: SizedBox()),
                                Flexible(
                                  flex: 6,
                                  child: General.buildTxt(
                                      txt: widget.name,englishLanguage: false,fontSize: 22.0),
                                ),
                              ],
                            ),
                            General.sizeBoxVerical(MediaQuery.of(context).size.height*0.03),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Constants.OrangeColor,width: 3.0),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Constants.ScaffoldColor,
                                          radius: 46.0,
                                          child: Center(
                                            child: General.buildTxt(txt: hospital.hospitalInfo.totalBeds.toString()),
                                          ),
                                        ),
                                      ),
                                      General.sizeBoxVerical(MediaQuery.of(context).size.height*0.005),
                                      General.buildTxt(txt: 'إجمالي عدد السرائر',englishLanguage: false,fontSize: 16),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Constants.OrangeColor,width: 3.0),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Constants.ScaffoldColor,
                                          radius: 46.0,
                                          child: Center(
                                            child: General.buildTxt(txt: hospital.hospitalInfo.totalCoronaBeds.toString()),
                                          ),
                                        ),
                                      ),
                                      General.sizeBoxVerical(MediaQuery.of(context).size.height*0.005),
                                      General.buildTxt(txt: 'السرائر المخصصة لكورونا',englishLanguage: false,fontSize: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            General.sizeBoxVerical(MediaQuery.of(context).size.height*0.01),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Constants.OrangeColor,width: 3.0),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Constants.ScaffoldColor,
                                          radius: 46.0,
                                          child: Center(
                                            child: General.buildTxt(txt: hospital.hospitalInfo.availableBeds.toString()),
                                          ),
                                        ),
                                      ),
                                      General.sizeBoxVerical(MediaQuery.of(context).size.height*0.005),
                                      General.buildTxt(txt: 'سرائر العناية المتاحة',englishLanguage: false,fontSize: 16),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Constants.OrangeColor,width: 3.0),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Constants.ScaffoldColor,
                                          radius: 46.0,
                                          child: Center(
                                            child: General.buildTxt(txt: hospital.hospitalInfo.availableCoronaBeds.toString()),
                                          ),
                                        ),
                                      ),
                                      General.sizeBoxVerical(MediaQuery.of(context).size.height*0.005),
                                      General.buildTxt(txt: 'سرائر كورونا المتاحة',englishLanguage: false,fontSize: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            General.sizeBoxVerical(MediaQuery.of(context).size.height*0.02),
                            Divider(color: Constants.GrayColor),
                            General.sizeBoxVerical(MediaQuery.of(context).size.height*0.01),
                            General.buildTxt(txt: 'Latest Updates',fontSize: 20.0),
                            General.sizeBoxVerical(MediaQuery.of(context).size.height*0.025),
                            (hospital.posts.isEmpty)
                                ? Center(
                              child: General.buildTxt(txt: 'The hospital has not added\n        any new news yet',
                                  color: Constants.GrayLightColor),
                            ) :
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
                                    height: MediaQuery.of(context).size.height,
                                  );
                                }
                            ),
                            General.sizeBoxVerical(MediaQuery.of(context).size.height*0.06),
                          ],
                        ),
                      ),
                    ),
                  ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height * 0.088,
          color: Constants.WhiteColor,
          child: Consumer<SearchNotifier>(
            builder: (context, hospital, child) =>
            (hospital.hospitalInfo == null) ?
            LargeButton(
              height: MediaQuery.of(context).size.height*0.8, width: MediaQuery.of(context).size.width,
              shadow: true, color: Constants.OrangeColor, load: true)
            : LargeButton(
            height: MediaQuery.of(context).size.height*0.8, width: MediaQuery.of(context).size.width,
            txt: hospital.hospitalInfo.orgPhoneNumber, shadow: true,
            txtColor: Constants.WhiteColor, color: Constants.OrangeColor,
            prefixIcon: true, call: true, load: false,
            txtBold: true, changeColorIcon: false, function: () async{
              String url = 'tel:${hospital.hospitalInfo.orgPhoneNumber}';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
             },
            ),
          ),
        ),
      ),
    );
  }
}