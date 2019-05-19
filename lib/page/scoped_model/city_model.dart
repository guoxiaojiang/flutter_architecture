import 'package:flutter_architecture/data/city.dart';
import 'package:flutter_architecture/data/repository.dart';
import 'package:scoped_model/scoped_model.dart';

class CityModel extends Model {
  final Repository _repository;

  CityModel(this._repository);

  bool _isLoading = false;
  CityData _cityData;

  bool get isLoading => _isLoading;

  CityData get cityData => _cityData;

  void loadCityData() {
    _isLoading = true;
    notifyListeners();
    _repository.getCityData().then((cityData) {
      _cityData = cityData;
      _isLoading = false;
      notifyListeners();
    });
  }
}
