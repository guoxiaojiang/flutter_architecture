import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import 'city.dart';

class Repository {

  Future<CityData> getCityData() async {
    try {
      Response response = await Dio().get("https://raw.githubusercontent.com/guoxiaojiang/flutter_architecture/master/testdata.json");
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
