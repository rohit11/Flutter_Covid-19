class WorldDataModel {
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final int affectedCountries;


  WorldDataModel({
  this.cases,
  this.todayCases,
  this.deaths,
  this.todayDeaths,
  this.recovered,
  this.active,
  this.critical,
  this.affectedCountries
  });

  WorldDataModel.fromJson(Map<String, dynamic> map)
      : cases = map['cases'],
        todayCases = map['todayCases'],
        todayDeaths = map['todayDeaths'],
        recovered = map['recovered'],
        active = map['active'],
        critical = map['critical'],
        affectedCountries = map['affectedCountries'],
        deaths = map['deaths'];
}