import 'package:covid_19/moreInformationDataModel.dart';
import 'package:flutter/material.dart';

class MoreInformationDetails extends StatelessWidget {
  final MoreInformationDataModel aboutDataModel;
  MoreInformationDetails({this.aboutDataModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(aboutDataModel.title),
        ),
        body: SafeArea(
                  child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                  alignment: Alignment.center,
                  child: Hero(
                      tag: aboutDataModel.id,
                      child: Image.asset(
                        aboutDataModel.imageName,
                        width: 120,
                        height: 120,
                      ),
                      ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Text(
                    aboutDataModel.title,
                    textDirection: TextDirection.ltr,
                    style: new TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(aboutDataModel.subTitle,
                      style: new TextStyle(
                        fontSize: 20.0,
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text("What to know",
                      style: new TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Text(aboutDataModel.description,
                      style: new TextStyle(
                        fontSize: 20.0,
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
