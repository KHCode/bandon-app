import 'package:bandon/screens/contact.dart';
import 'package:bandon/screens/dining.dart';
import 'package:bandon/screens/events.dart';
import 'package:bandon/screens/find-business.dart';
import 'package:bandon/screens/getting-started.dart';
import 'package:bandon/screens/home_page.dart';
import 'package:bandon/screens/lodging.dart';
import 'package:bandon/screens/things-to-do.dart';
import 'package:bandon/screens/relocate_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:flutter/services.dart';

import '../app.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({Key key}) : super(key: key);

  SettingsDrawerState createState() => SettingsDrawerState();
}

class SettingsDrawerState extends State<SettingsDrawer> {
  bool _locationEnabled = false;

  bool _getDarkModeStatus(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? true : false;
  void _toggleTheme(AppState appState) => appState.toggleTheme();

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

  Future<bool> _getLocationServicesStatus() async =>
      Geolocator.isLocationServiceEnabled();

  Future<bool> _getAppLocationPermissionStatus() async {
    bool _result = false;
    LocationPermission _permission = await Geolocator.checkPermission();

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
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    AppState appState = context.findAncestorStateOfType<AppState>();

    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xFF05668d),
          ),
          child: Text(
            'More to learn about Bandon',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        Container(
          color: Color(0xFF05668d),
          child: Column(
            children: [
              ListTile(
                dense: true,
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(HomePage.routeName),
              ),
              ListTile(
                dense: true,
                title: Text(
                  'Start Here',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(GetStartedScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: Text(
                  'Dining',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(DiningScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: Text(
                  'Lodging',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(LodgingScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: Text(
                  'Things To Do',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(ThingsToDoScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: Text(
                  'Events',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(EventsScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: Text(
                  'Find a Business',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () => Navigator.of(context)
                    .pushNamed(FindBusinessScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: Text(
                  'Contact',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(ContactScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: Text(
                  'Relocate Here',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(RelocateScreen.routeName),
              ),
              SwitchListTile(
                secondary: Icon(Icons.location_on),
                title: Text(
                  'Location access',
                  style: TextStyle(color: Colors.white),
                ),
                isThreeLine: true,
                value: _locationEnabled,
                onChanged: null,
                subtitle: InkWell(
                  child: Text(
                    "Tap here to review your device settings",
                    style: TextStyle(color: Colors.white70),
                  ),
                  onTap: () {
                    Geolocator.openAppSettings();
                  },
                ),
              ),
              SwitchListTile(
                secondary: Icon(Icons.settings_brightness),
                title: Text(
                  'Dark Mode',
                  style: TextStyle(color: Colors.white),
                ),
                value: _getDarkModeStatus(context),
                onChanged: (value) => _toggleTheme(appState),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
