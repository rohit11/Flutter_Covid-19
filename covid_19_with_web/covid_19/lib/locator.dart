import 'package:covid_19/dataModel/historicalDataModel.dart';
import 'package:covid_19/dataModel/worldDataModel.dart';
import 'package:covid_19/services/api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
    locator.registerLazySingleton(() => Api());
    locator.registerFactory(() => WorldDataModel());
    locator.registerFactory(() => Historical());

}