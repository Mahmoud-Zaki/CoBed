import 'package:cobed/Componants/ShadowContainer.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:cobed/Utils/General.dart';
import 'package:flutter/material.dart';

class PreventiveMeasures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Constants.ScaffoldColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Constants.GrayColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.18,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Container(
                  color: Constants.ScaffoldColor,
                ),
                title: General.buildTxt(
                    txt: 'Preventive Measures',
                    fontSize: 20,
                    color: Constants.GrayColor),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.05),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  ShadowContainer(
                    txt: 'نظف يديك كثيرًا باستخدم الصابون والماء أو مطهر اليدين',
                    width: MediaQuery.of(context).size.width,
                    img: 'Assets/ilu-1.png',
                    imgDirection: 'left',
                  ),
                  General.sizeBoxVerical(30.0),
                  ShadowContainer(
                    txt: 'الحفاظ علي التباعد الاجتماعي بمسافة قدرها 2 متر',
                    width: MediaQuery.of(context).size.width,
                    img: 'Assets/ilu-2.png',
                    imgDirection: 'right',
                  ),
                  General.sizeBoxVerical(30.0),
                  ShadowContainer(
                    txt: 'ارتد الكمامة خارج المنزل',
                    width: MediaQuery.of(context).size.width,
                    img: 'Assets/ilu-3.png',
                    imgDirection: 'left',
                  ),
                  General.sizeBoxVerical(30.0),
                  ShadowContainer(
                    txt:
                        'قم بتغطية أنفك وفمك بكوعك المثني أو بمنديل ورقي عند السعال أو العطس',
                    width: MediaQuery.of(context).size.width,
                    img: 'Assets/ilu-4.png',
                    imgDirection: 'right',
                  ),
                  General.sizeBoxVerical(30.0),
                  ShadowContainer(
                    txt: 'لا تلمس عينيك أو أنفك أو فمك',
                    width: MediaQuery.of(context).size.width,
                    img: 'Assets/ilu-5.png',
                    imgDirection: 'left',
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}