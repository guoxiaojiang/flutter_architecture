import 'package:flutter/foundation.dart';
import 'package:flutter_architecture/data/city.dart';
import 'package:flutter_architecture/data/repository.dart';

class CitySchedule extends ChangeNotifier {
  static const state_init = 0;
  static const state_loading = 1;
  static const state_loaded = 2;

  int _state = state_init;

  int get state => _state;

  CityData _cityData;

  CityData get cityData => _cityData;

  Repository _repository;

  set repository(Repository repository) {
    _repository = repository;
  }

  void setStateAndData(int value, {CityData cityData}) {
    _state = value;
    if (cityData != null) {
      _cityData = cityData;
    }
    notifyListeners();
  }

  void getCityData() {
    setStateAndData(state_loading);
    _repository.getCityData().then((cityData) {
      setStateAndData(state_loaded, cityData: cityData);
    });
  }

}
