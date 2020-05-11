import 'package:flutter/material.dart';
import 'package:weatherapp/app.dart';
import 'package:weatherapp/core/app/app_config.dart';

void main() => runApp(
      WeatherApp(
        appConfig: StageConfig(),
      ),
    );
