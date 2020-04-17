import 'package:covid_19/dataModel/countriesDataModel.dart';
import 'package:covid_19/dataModel/historicalDataModel.dart';
import 'package:covid_19/dataModel/worldDataModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Api {
  static const String _apiEndPoint = "https://corona.lmao.ninja";

  Future<dynamic> getWordData() async {
    var response = await http.get('$_apiEndPoint/v2/all');

    if(response.statusCode == 200) {
      var worldData = json.decode(response.body);
      var worldDataResponse = WorldDataModel.fromJson(worldData);
      return worldDataResponse;
    }
    return 'Could not featch data at this time';
  }

  Future<dynamic> getCountryData() async {
    var response = await http.get('$_apiEndPoint/v2/countries?sort=cases');

    if(response.statusCode == 200) {
      var countryData = (json.decode(response.body) as List)
      .map((episode) => Country.fromJson(episode))
          .toList();
      return countryData;
    }
    return 'Could not featch data at this time';
  }

  Future<dynamic> getCountryHistory(String country) async {
    var response = await http.get('$_apiEndPoint/v2/historical/$country?lastdays=all');

    if(response.statusCode == 200) {
      final countryHistory = json.decode(response.body);
      final countryHistoryResponse = Historical.fromJson(countryHistory);
      return countryHistoryResponse;
    }
    return 'Could not featch data at this time';
  }

}