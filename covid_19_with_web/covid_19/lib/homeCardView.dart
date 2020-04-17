

import 'package:covid_19/dataModel/homeCardDataModel.dart';
import 'package:flutter/material.dart';

class HomeCardView extends StatelessWidget {
  final CasesDataModel homeCardDataModel;
  final isHomeScreen;
  HomeCardView({this.homeCardDataModel, this.isHomeScreen = true});

   Widget getHomeCard(HomeCardViewModel viewModel) {
     return Card(
        child: Container(
          color: Colors.grey[850],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               Container(
                  padding: EdgeInsets.all( isHomeScreen == true ? 16 : 8) ,
                 child: Text(
                   viewModel.headerTitle,
                  textAlign:TextAlign.center,
                 style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isHomeScreen == true ? 20 : 16))
                 ),
               ListTile(
                leading: Image.asset(viewModel.imageUrl, height: 45, width: 45,),
                title: Text(viewModel.title , textAlign: TextAlign.right, style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: viewModel.fontSize,
                          color:viewModel.color)),
                subtitle: Text(viewModel.subTitle, textAlign: TextAlign.right,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isHomeScreen == true ? 16 : 14,
                          color:viewModel.color)),
              )
            ],
          ),
        ),
      );
   }
  @override
  Widget build(BuildContext context) {
    final HomeCardViewModel viewModel = HomeCardViewModel.getHomeCardViewDataModel(homeCardDataModel);
    return   getHomeCard(viewModel);
  }
}