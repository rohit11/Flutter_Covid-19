import 'package:covid_19/constant.dart';
import 'package:covid_19/dataModel/countriesDataModel.dart';
import 'package:covid_19/dataModel/homeCardDataModel.dart';
import 'package:covid_19/dataModel/worldDataModel.dart';
import 'package:covid_19/homeCardView.dart';
import 'package:flutter/material.dart';


class Cases extends StatelessWidget {
final WorldDataModel wordDataModel;
final homescreen;
final Country country;
Cases({this.wordDataModel, this.country, this.homescreen = true});


  Widget homeScreen() {
    return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: Text('World Wide Status',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            ),
            HomeCardView(
                homeCardDataModel: CasesDataModel(
                    type: CaseType.totalCases,
                    cases: wordDataModel.cases, todayCases: wordDataModel.todayCases)),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: HomeCardView(
                        homeCardDataModel: CasesDataModel(
                            type: CaseType.totalDeath,
                            deaths: wordDataModel.deaths, todayDeaths: wordDataModel.todayDeaths)),
                  ),
                  Expanded(
                    flex: 2,
                    child: HomeCardView(
                        homeCardDataModel: CasesDataModel(
                            type: CaseType.totalRecoved,
                            recovered: wordDataModel.recovered)),
                  ),
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: HomeCardView(
                        homeCardDataModel: CasesDataModel(
                            type: CaseType.totalCritical,
                            critical: wordDataModel.critical)),
                  ),
                  Expanded(
                    flex: 2,
                    child: HomeCardView(
                        homeCardDataModel: CasesDataModel(
                            type: CaseType.affectedCountries,
                            affectedCountries: wordDataModel.affectedCountries)),
                  ),
                ],
              ),
            ),
          ],
        );
  }

  Widget countryScreen() {
    return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 75, bottom: 8),
              child: Text(country.country,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            ),
            HomeCardView(
                homeCardDataModel: CasesDataModel(
                    type: CaseType.totalCases,
                    cases: country.cases, todayCases: country.todayCases), isHomeScreen: false,),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: HomeCardView(
                        homeCardDataModel: CasesDataModel(
                            type: CaseType.totalDeath,
                            deaths: country.deaths, todayDeaths: country.todayDeaths), isHomeScreen: false),
                  ),
                  Expanded(
                    flex: 2,
                    child: HomeCardView(
                        homeCardDataModel: CasesDataModel(
                            type: CaseType.totalRecoved,
                            recovered: country.recovered), isHomeScreen: false),
                  ),
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: HomeCardView(
                        homeCardDataModel: CasesDataModel(
                            type: CaseType.totalCritical,
                            critical: country.critical), isHomeScreen: false),
                  ),
                  Expanded(
                    flex: 2,
                    child: HomeCardView(
                        homeCardDataModel: CasesDataModel(
                            type: CaseType.active,
                            active: country.active), isHomeScreen: false),
                  ),
                ],
              ),
            ),
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    return homescreen == true ? homeScreen() : countryScreen();
  }
}