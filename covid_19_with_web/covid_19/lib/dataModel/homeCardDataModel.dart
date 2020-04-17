

import 'package:covid_19/constant.dart';
import 'package:flutter/material.dart';



class HomeCardViewModel {

  String headerTitle;
  String title;
  String subTitle;
  String imageUrl;
  Color  color;
  double fontSize;

  
  static HomeCardViewModel getHomeCardViewDataModel(CasesDataModel homeCardDataModel) {

    HomeCardViewModel homeCardViewModel;

    if(homeCardDataModel == null) {
      homeCardViewModel = HomeCardViewModel();
        homeCardViewModel.headerTitle = 'Not Available';
        homeCardViewModel.title  ='123456';
        homeCardViewModel.subTitle  = '123456';
        homeCardViewModel.imageUrl = 'assets/img/totalcases.png';
        homeCardViewModel.color = Colors.white;
        homeCardViewModel.fontSize = 20;
        return homeCardViewModel;
    }
    switch(homeCardDataModel.type) {

      case CaseType.totalCases : {
        homeCardViewModel = HomeCardViewModel();
        homeCardViewModel.headerTitle = 'Total Cases';
        homeCardViewModel.title  = getFormattedString(homeCardDataModel.cases.toString());
        homeCardViewModel.subTitle  = '+' + getFormattedString(homeCardDataModel.todayCases.toString());
        homeCardViewModel.imageUrl = 'assets/img/totalcases.png';
        homeCardViewModel.color = Colors.green;
        homeCardViewModel.fontSize = 40;

      }
      break;

      case CaseType.totalDeath : {
        homeCardViewModel = HomeCardViewModel();
        homeCardViewModel.headerTitle = 'Total Deaths';
        homeCardViewModel.title  = getFormattedString(homeCardDataModel.deaths.toString());
        homeCardViewModel.subTitle  = '+' + getFormattedString(homeCardDataModel.todayDeaths.toString());
        homeCardViewModel.imageUrl = 'assets/img/totalDeath.png';
        homeCardViewModel.color = Colors.red;
        homeCardViewModel.fontSize = 18;
      }
      break;

      case CaseType.totalRecoved : {
        homeCardViewModel = HomeCardViewModel();
        homeCardViewModel.headerTitle = 'Total Recoverd';
        homeCardViewModel.title  = getFormattedString(homeCardDataModel.recovered.toString());
        homeCardViewModel.subTitle  = '';  
        homeCardViewModel.imageUrl = 'assets/img/totalRecovered.png';
        homeCardViewModel.color = Colors.orange;
        homeCardViewModel.fontSize = 18;
      }
      break;

      case CaseType.totalCritical : {
        homeCardViewModel = HomeCardViewModel();
        homeCardViewModel.headerTitle = 'Total Critical\n';
        homeCardViewModel.title  = getFormattedString(homeCardDataModel.critical.toString());
        homeCardViewModel.subTitle  = ''; 
        homeCardViewModel.imageUrl = 'assets/img/totalCritical.png';
        homeCardViewModel.color = Colors.yellow;
        homeCardViewModel.fontSize = 18;
      }
      break;

      case CaseType.affectedCountries : {
        homeCardViewModel = HomeCardViewModel();
        homeCardViewModel.headerTitle = 'Countries Affected';
        homeCardViewModel.title  = getFormattedString(homeCardDataModel.affectedCountries.toString());
        homeCardViewModel.subTitle  = '';
        homeCardViewModel.imageUrl = 'assets/img/totalCountries.png'; 
        homeCardViewModel.color = Colors.blue;
        homeCardViewModel.fontSize = 18;
      }
      break;

      case CaseType.active : {
        homeCardViewModel = HomeCardViewModel();
        homeCardViewModel.headerTitle = 'Total Active';
        homeCardViewModel.title  = getFormattedString(homeCardDataModel.active.toString());
        homeCardViewModel.subTitle  = '';
        homeCardViewModel.imageUrl = 'assets/img/totalCountries.png'; 
        homeCardViewModel.color = Colors.blue;
        homeCardViewModel.fontSize = 18;
      }
      break;

    }
    return homeCardViewModel;
  }
}

class CasesDataModel {
  CaseType type;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int critical;
  int affectedCountries;
  int active;

  CasesDataModel({this.type, this.cases, this.todayCases, this.deaths, this.todayDeaths, this.recovered,this.critical, this.affectedCountries, this.active});

}