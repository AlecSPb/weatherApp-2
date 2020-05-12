import 'package:location/location.dart';

class LocationProvider {
  LocationData userLocation;

  LocationProvider() {
    updatePosition();
  }

  Future<void> updatePosition() async {
    userLocation = await Location().getLocation();
  }
}
