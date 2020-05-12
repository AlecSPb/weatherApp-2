import 'dart:async';

class LocationBloc {
  final locationController = StreamController<dynamic>();

  Function(dynamic) get changeLocation => locationController.sink.add;
}
