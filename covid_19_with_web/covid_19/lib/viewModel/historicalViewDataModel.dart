import 'package:covid_19/dataModel/historicalDataModel.dart';
import 'package:covid_19/locator.dart';
import 'package:covid_19/services/api.dart';
import 'package:flutter/material.dart';

class HistoricalViewDataModel extends ChangeNotifier {
    final _api = locator<Api>();

  Historical _historicalDataModel;
  Historical get historicalDataModel => _historicalDataModel;

  bool _busy;
  bool get busy => _busy;

  String _errorMessage;
  String get errorMessage => _errorMessage;

  Future getCountryHistory(String country) async {
    _setBusy(true);
    var countryHistory = await _api.getCountryHistory(country);

    if (countryHistory is String) {
      _errorMessage = countryHistory;
    } else {
      _historicalDataModel = countryHistory;
    }

    _setBusy(false);
  }

  void _setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

}