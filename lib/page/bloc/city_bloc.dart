import 'dart:async';

import 'package:flutter_architecture/data/city.dart';
import 'package:flutter_architecture/data/repository.dart';

class CityBloc {
  CityBloc(this._repository);

  final Repository _repository;

  final _cityStreamController = StreamController<CityDataState>();

  Stream<CityDataState> get city => _cityStreamController.stream;

  void loadCitiesData() {
    CityDataState cityDataState = CityDataState();
    cityDataState.state = CityDataState.state_loading;
    _cityStreamController.sink.add(cityDataState);
    _repository.getCityData().then((cityData) {
      cityDataState.state = CityDataState.state_loaded;
      cityDataState.cityData = cityData;
      _cityStreamController.sink.add(cityDataState);
    });
  }

  void dispose() {
    _cityStreamController.close();
  }
}

class CityDataState {
  CityDataState();

  CityData _cityData;

  int _state = 0;

  static const state_init = 0;
  static const state_loading = 1;
  static const state_loaded = 2;

  set cityData(CityData cityData) => _cityData = cityData;

  CityData get cityData => _cityData;

  set state(int state) => _state = state;

  int get state => _state;
}
