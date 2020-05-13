import 'dart:async';

import 'package:location/location.dart';
import 'package:rxdart/subjects.dart';

class GeolocationBloc {
  final _locationController = BehaviorSubject<LocationData>();

  // For accessing data in a StreamBuilder
  Stream<LocationData> get currentLocation => _locationController.stream;

  // Change data
  Function(LocationData) get changeLocation => _locationController.sink.add;

  dispose() {
    _locationController.close();
  }
}
