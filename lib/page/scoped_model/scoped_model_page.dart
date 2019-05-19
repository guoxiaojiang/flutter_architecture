import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/repository.dart';
import 'package:scoped_model/scoped_model.dart';

import 'city_model.dart';

class ScopedModelPage extends StatefulWidget {
  final Repository _repository;

  ScopedModelPage(this._repository);

  @override
  State<StatefulWidget> createState() => _ScopedModelPageState();
}

class _ScopedModelPageState extends State<ScopedModelPage> {
  CityModel _cityModel;

  @override
  void initState() {
    _cityModel = CityModel(widget._repository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _cityModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scoped model'),
        ),
        body: SafeArea(
          child: ScopedModelDescendant<CityModel>(
            builder: (context, child, model) {
              if (model.isLoading) {
                return _buildLoading();
              } else {
                if (model.cityData != null) {
                  return _buildContent(model);
                } else {
                  return _buildInit(model);
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInit(CityModel userModel) {
    return Center(
      child: RaisedButton(
        child: const Text('Load cities data'),
        onPressed: () {
          userModel.loadCityData();
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(CityModel cityModel) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "山西省的城市有如下：",
            style: TextStyle(fontSize: 19),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: cityModel.cityData.cities.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(
                  cityModel.cityData.cities[index].cityName,
                  style: TextStyle(fontSize: 18),
                ));
              }),
        ),
      ],
    );
  }
}
