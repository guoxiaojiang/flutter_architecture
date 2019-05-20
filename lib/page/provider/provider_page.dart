import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/city.dart';
import 'package:flutter_architecture/data/repository.dart';
import 'package:provider/provider.dart';

import 'city_schedule.dart';

class ProviderPage extends StatefulWidget {
  final Repository _repository;

  ProviderPage(this._repository);

  @override
  State<StatefulWidget> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider"),
      ),
      body: SafeArea(
          child: ChangeNotifierProvider(
        builder: (context) {
          return CitySchedule()..repository = widget._repository;
        },
        child: Consumer<CitySchedule>(
          builder: (context, schedule, _) {
            if (schedule.state == CitySchedule.state_init) {
              return _buildInit(context, schedule);
            } else if (schedule.state == CitySchedule.state_loading) {
              return _buildLoading();
            } else if (schedule.state == CitySchedule.state_loaded) {
              return _buildContent(schedule.cityData);
            }
          },
        ),
      )),
    );
  }

  Widget _buildInit(BuildContext context, CitySchedule schedule) {
    return ChangeNotifierProvider<CitySchedule>(
      builder: (context) => CitySchedule(),
      child: Center(
        child: RaisedButton(
          child: const Text('Load cities data'),
          onPressed: () {
            schedule.getCityData();
          },
        ),
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
