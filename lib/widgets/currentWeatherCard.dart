import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/data/scopes/weather_scope.dart';
import 'package:weatherapp/models/weatherDataset.dart';
import 'package:weatherapp/providers/global/config/config_provider.dart';
import 'package:weatherapp/util/extensions/string_extension.dart';

class CurrentWeatherCard extends StatefulWidget {
  const CurrentWeatherCard(this.data);

  final WeatherDataset data;

  @override
  _CurrentWeatherCardState createState() => _CurrentWeatherCardState();
}

class _CurrentWeatherCardState extends State<CurrentWeatherCard> {
  bool _showDegreeSymbol;

  @override
  void initState() {
    super.initState();
    _showDegreeSymbol = true;
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _showDegreeSymbol = !_showDegreeSymbol;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConfigProvider configProvider = Provider.of<ConfigProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 400.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("${widget.data.temp.toString()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                      )),
                  Text("°",
                      style: TextStyle(
                        color: _showDegreeSymbol
                            ? Colors.white
                            : Colors.transparent,
                        fontSize: 64,
                      )),
                ],
              ),
              Text("${widget.data.name}",
                  style: TextStyle(color: Colors.white)),
              Text(
                "${widget.data.description.capitalize()}",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Image.network(
                '${configProvider.appConfig.openWeatherImageUrl}/${widget.data.icon}@2x.png',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
