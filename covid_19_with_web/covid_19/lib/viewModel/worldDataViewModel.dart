

import 'dart:io';

import 'package:covid_19/dataModel/worldDataModel.dart';
import 'package:covid_19/locator.dart';
import 'package:covid_19/services/api.dart';
import 'package:flutter/material.dart';

class WorldDataViewModel extends ChangeNotifier {
    final _api = locator<Api>();

  WorldDataModel _wordDataModel;
  WorldDataModel get wordDataModel => _wordDataModel;

  bool _busy;
  bool get busy => _busy;

  String _errorMessage;
  String get errorMessage => _errorMessage;

  Future getWordData() async {

    try {
  
  _setBusy(true);
    var episodesResuls = await _api.getWordData();

    if (episodesResuls is String) {
      _errorMessage = episodesResuls;
    } else {
      _wordDataModel = episodesResuls;
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

}