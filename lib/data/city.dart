class CityData {
  int _result;
  List<City> _cities;

  CityData({int result, List<City> cities}) {
    this._result = result;
    this._cities = cities;
  }

  int get result => _result;

  set result(int result) => _result = result;

  List<City> get cities => _cities;

  set cities(List<City> cities) => _cities = cities;

  CityData.fromJson(Map<String, dynamic> json) {
    _result = json['result'];
    if (json['cities'] != null) {
      _cities = new List<City>();
      json['cities'].forEach((v) {
        _cities.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this._result;
    if (this._cities != null) {
      data['cities'] = this._cities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  String _cityName;

  City({String cityName}) {
    this._cityName = cityName;
  }

  String get cityName => _cityName;

  set cityName(String cityName) => _cityName = cityName;

  City.fromJson(Map<String, dynamic> json) {
    _cityName = json['citysName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['citysName'] = this._cityName;
    return data;
  }
}
