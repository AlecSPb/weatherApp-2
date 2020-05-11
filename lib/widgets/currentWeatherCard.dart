import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weatherapp/data/injectors/weather_injector.dart';
import 'package:weatherapp/models/weatherDataset.dart';

class CurrentWeatherCard extends StatefulWidget {
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
    final weatherBloc = WeatherInjector.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 400.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: weatherBloc.currentWeather,
                builder: (BuildContext context,
                    AsyncSnapshot<WeatherDataset> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Theme(
                        data: Theme.of(context)
                            .copyWith(accentColor: Colors.white),
                        child: new CircularProgressIndicator(),
                      );
                    default:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            'https://openweathermap.org/img/wn/${snapshot.data.icon}@2x.png',
                          ),
                          Row(
                            children: <Widget>[
                              Text("${snapshot.data.temp.toString()} ",
                                  style: TextStyle(color: Colors.white)),
                              Text("°",
                                  style: TextStyle(
                                      color: _showDegreeSymbol
                                          ? Colors.white
                                          : Colors.transparent)),
                              Text("C", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          Text("${snapshot.data.name}",
                              style: TextStyle(color: Colors.white)),
                        ],
                      );
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}