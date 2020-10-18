import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:flutter/services.dart';

// import '../app.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({Key key}) : super(key: key);

  SettingsDrawerState createState() => SettingsDrawerState();
}

class SettingsDrawerState extends State<SettingsDrawer> {
  bool _locationEnabled = false;

  void initState() {
    super.initState();
    _getLocationOverallStatus();
  }

  // void _toggleLocationUsage() async {
  //   try {
  //     await requestPermission();
  //   } on PermissionRequestInProgressException catch (e) {
  //     print('Error: ${e.toString()}');
  //   }
  // }

  Future<bool> _getLocationServicesStatus() async => isLocationServiceEnabled();

  Future<bool> _getAppLocationPermissionStatus() async {
    bool _result = false;
    LocationPermission _permission = await checkPermission();

    switch (_permission) {
      case LocationPermission.whileInUse:
        print('Location permissions allowed while in use');
        _result = true;
        break;
      case LocationPermission.always:
        print('Location permissions are always allowed');
        _result = true;
        break;
      case LocationPermission.denied:
        print('Location permissions were denied');
        break;
      case LocationPermission.deniedForever:
        print('Location permissions were denied forever');
        break;
      default:
        print('Couldn\'t determine location permissions');
    }

    return _result;
  }

  Future<void> _getLocationOverallStatus() async {
    _locationEnabled = (await _getLocationServicesStatus() &&
        await _getAppLocationPermissionStatus());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // AppState appState = context.findAncestorStateOfType<AppState>();

    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
          ),
          child: Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        SwitchListTile(
          secondary: Icon(Icons.location_on),
          title: Text('Location access'),
          isThreeLine: true,
          value: _locationEnabled,
          onChanged: null,
          subtitle: InkWell(
            child: Text("Tap here to review your device settings"),
            onTap: () {
              openAppSettings();
            },
          ),
        ),
      ],
    ));
  }
}
