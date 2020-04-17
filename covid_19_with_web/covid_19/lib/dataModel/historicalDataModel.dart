class Historical {
  String country;
  List<String> provinces;
  Timeline timeline;

  Historical({this.country, this.provinces, this.timeline});

  Historical.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    provinces = json['provinces'].cast<String>();
    timeline = json['timeline'] != null
        ? new Timeline.fromJson(json['timeline'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['provinces'] = this.provinces;
    if (this.timeline != null) {
      data['timeline'] = this.timeline.toJson();
    }
    return data;
  }
}

class Timeline {
  Map<String, dynamic> cases;
  Map<String, dynamic> deaths;
  Map<String, dynamic> recovered;

  Timeline({this.cases, this.deaths, this.recovered});

  Timeline.fromJson(Map<String, dynamic> json) {
    cases = json['cases'] != null ? json['cases'] : null;
    deaths = json['deaths'] != null ? json['deaths'] : null;
    recovered = json['recovered'] != null
        ? json['recovered']
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cases != null) {
      data['cases'] = this.cases;
    }
    if (this.deaths != null) {
      data['deaths'] = this.deaths;
    }
    if (this.recovered != null) {
      data['recovered'] = this.recovered;
    }
    return data;
  }
}


