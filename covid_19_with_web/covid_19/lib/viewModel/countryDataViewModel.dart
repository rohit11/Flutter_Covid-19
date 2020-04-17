import 'dart:io';

import 'package:covid_19/constant.dart';
import 'package:covid_19/dataModel/countriesDataModel.dart';
import 'package:covid_19/locator.dart';
import 'package:covid_19/services/api.dart';
import 'package:flutter/material.dart';

class CountryDataViewModel extends ChangeNotifier {
    final _api = locator<Api>();

  List<Country> _countryDataModel;
  List<Country> _finalCountryDataModel;

  List<Country> get countryDataModel => _countryDataModel;

  bool _busy;
  bool get busy => _busy;

  String _errorMessage;
  String get errorMessage => _errorMessage;

  Future getCountryData() async {

    try {
    _setBusy(true);
    var countryResult = await _api.getCountryData();

    if (countryResult is String) {
      _errorMessage = countryResult;
    } else {
      _countryDataModel = countryResult;
      _finalCountryDataModel = countryResult;
    }
    _setBusy(false);
    } on SocketException catch (_) {
      _errorMessage = 'Check your Internet connection';
      _setBusy(false);
    }
  }

  void _setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  Future filterCountries(String str) async {
    _countryDataModel = _finalCountryDataModel;
    _countryDataModel = countryDataModel.where((i) => i.country.toLowerCase().contains(str.toLowerCase())).toList();
    notifyListeners();
  }
  Future filterCasesHighToLow(bool isHighToLow) async {
        if(isHighToLow == false){
        //_countryDataModel = _finalCountryDataModel;
        _countryDataModel.sort((a, b) => a.cases.compareTo(b.cases));
        } else {
           //_countryDataModel = _finalCountryDataModel;
          _countryDataModel.sort((b, a) => a.cases.compareTo(b.cases));
        }
         notifyListeners();
  }
  Future filterDeathHighToLow(bool isHighToLow) async {
        if(isHighToLow == false){
        //_countryDataModel = _finalCountryDataModel;
        _countryDataModel.sort((a, b) => a.deaths.compareTo(b.deaths));
        } else {
           //_countryDataModel = _finalCountryDataModel;
          _countryDataModel.sort((b, a) => a.deaths.compareTo(b.deaths));
        }
         notifyListeners();
  }

List<T> intersection<T>(Iterable<T> a, Iterable<T> b) {
  final s = b.toSet();
  return a.toSet().where((x) => s.contains(x)).toList();
}

Future getFavList() async {
   final favList = await getFavCountryList();
  _countryDataModel = _finalCountryDataModel;
  final s = favList.toSet();
  final actual = _countryDataModel.toSet();
   _countryDataModel = actual.where((x) => s.contains(x.countryInfo.iId.toString())).toList();
  notifyListeners();
}

  void updateToView() {
   notifyListeners();
  }
  void resetList() {
    _countryDataModel = _finalCountryDataModel;
    notifyListeners();
  }
}