import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/city.dart';
import 'package:flutter_architecture/data/repository.dart';

class SetStatePage extends StatefulWidget {
  final Repository _repository;

  SetStatePage(this._repository);

  @override
  State<StatefulWidget> createState() {
    return _SetStatePageState();
  }
}

class _SetStatePageState extends State<SetStatePage> {
  bool _isLoading = false;
  CityData _cityData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetState'),
      ),
      body: SafeArea(child: _isLoading ? _buildLoading() : _buildBody()),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildBody() {
    if (_cityData != null) {
      return _buildContent();
    } else {
      return _buildInit();
    }
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("山西省的城市有如下：", style: TextStyle(fontSize: 19),),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: _cityData.cities.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(
                  _cityData.cities[index].cityName,
                  style: TextStyle(fontSize: 18),
                ));
              }),
        ),
      ],
    );
  }

  Widget _buildInit() {
    return Center(
      child: RaisedButton(
        child: const Text('Load cities data'),
        onPressed: () {
          //凡是状态（数据）更新时，使用setState 通知当前_SetStatePageState
          //_SetStatePageState的build会被重新执行
          //所以SetStatePage当前所有的Widget都会被重绘
          setState(() {
            _isLoading = true;
          });
          widget._repository.getCityData().then((cityData) {
            setState(() {
              _cityData = cityData;
              _isLoading = false;
            });
          });
        },
      ),
    );
  }
}
