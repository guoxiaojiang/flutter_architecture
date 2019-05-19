import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/city.dart';
import 'package:flutter_architecture/data/repository.dart';

import 'city_bloc.dart';

class BlocPage extends StatefulWidget {
  BlocPage(this._repository);

  final Repository _repository;

  @override
  State<StatefulWidget> createState() => _BlocPageState();
}

class _BlocPageState extends State<BlocPage> {
  CityBloc _cityBloc;

  @override
  void initState() {
    _cityBloc = CityBloc(widget._repository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BLoC"),
      ),
      body: SafeArea(
          child: StreamBuilder<CityDataState>(
        stream: _cityBloc.city,
        initialData: CityDataState(),
        builder: (context, snapshot) {
         switch(snapshot.data.state) {
           case CityDataState.state_init:
             return _buildInit();
             break;
           case CityDataState.state_loading:
             return _buildLoading();
             break;
           case CityDataState.state_loaded:
             return _buildContent(snapshot.data.cityData);
             break;
         }
        },
      )),
    );
  }

  Widget _buildInit() {
    return Center(
      child: RaisedButton(
        child: const Text('Load cities data'),
        onPressed: () {
          _cityBloc.loadCitiesData();
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(CityData cityData) {
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
              itemCount: cityData.cities.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(
                      cityData.cities[index].cityName,
                      style: TextStyle(fontSize: 18),
                    ));
              }),
        ),
      ],
    );
  }

}
