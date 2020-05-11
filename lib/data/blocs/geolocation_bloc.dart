import 'dart:async';

class GeolocationBloc {
  final locationController = StreamController<dynamic>();

  Function(dynamic) get changeLocation => locationController.sink.add;
}
