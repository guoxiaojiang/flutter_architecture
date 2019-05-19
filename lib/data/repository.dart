import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import 'city.dart';

class Repository {

  Future<CityData> getCityData() async {
    const url = "https://raw.githubusercontent.com/guoxiaojiang/flutter_architecture/master/testdata.json";
    try {
      Response response = await Dio().get(url);
      String cityDataStr = response.data.toString();
      final jsonMap = json.decode(cityDataStr);
      CityData cityData = CityData.fromJson(jsonMap);
      return cityData;
    } catch (e) {
      print(e);
    }
    return null;
  }

}
