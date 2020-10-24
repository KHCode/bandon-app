import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class TestDistanceDisplay extends StatefulWidget {
  @override
  _TestDistanceDisplayState createState() => _TestDistanceDisplayState();
}

class _TestDistanceDisplayState extends State<TestDistanceDisplay> {
  void initState() {
    super.initState();
    writeMessage();
  }

  static const String testDestination = "20 10th Street SE Bandon, OR 97411";
  static const String testBusiness = "Bandon Bicycle Works";
  String message = "";

  void writeMessage() async {
    LocationPermission _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied ||
        _permission == LocationPermission.deniedForever) {
      message = "We couldn't determine your current location. Please check your"
          " device settings for more information.";
    } else {
      String distance = await calcDistanceInMiles();
      message = "You\'re $distance miles away from $testBusiness.";
    }
    print("Updating state");
    setState(() {});
  }

  Future<double> getMetersFromAddress(String address) async {
    Position _position;
    try {
      _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } on PermissionRequestInProgressException catch (e) {
      print('Error: ${e.toString()}');
    }

    List<Location> _locations =
        await locationFromAddress(address, localeIdentifier: "en_US");

    return Geolocator.distanceBetween(_position.latitude, _position.longitude,
        _locations[0].latitude, _locations[0].longitude);
  }

  Future<String> calcDistanceInMiles() async {
    double distanceMeters = await getMetersFromAddress(testDestination);
    return (distanceMeters / 1609.344).toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 64.0, 16.0, 0.0),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 22.0,
        ),
      ),
    );
  }
}
