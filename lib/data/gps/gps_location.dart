import 'package:clean_arch_weather/domain/model/location.dart';
import 'package:location/location.dart';

class GetLocation {
  static Future<Location?> getPermission() async {
    var location = Location();
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return location;
  }

  static Future<CurrentLocation?> getLocation() async {
    var location = await getPermission();
    if (location != null) {
      var curLocation = await location.getLocation();
      return CurrentLocation(
          lat: curLocation.latitude!, lon: curLocation.longitude!);
    }
    return null;
  }
}
