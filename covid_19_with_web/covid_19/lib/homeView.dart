import 'package:covid_19/dataModel/worldDataModel.dart';
import 'package:covid_19/widgets/cases.dart';
import 'package:flutter/material.dart';
import 'corausal.dart';

class HomeView extends StatelessWidget {
  final WorldDataModel wordDataModel;
  HomeView({this.wordDataModel});
  Widget getWorldWideStatus(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        color: Theme.of(context).primaryColor,
        child: Cases(wordDataModel: wordDataModel,homescreen: true,));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getWorldWideStatus(context),
           CarouselDemo(),
        ],
      ),
    );
  }
}
