import 'package:bandon/screens/contact.dart';
import 'package:bandon/screens/dining.dart';
import 'package:bandon/screens/events.dart';
import 'package:bandon/screens/find-business.dart';
import 'package:bandon/screens/getting-started.dart';
import 'package:bandon/screens/home_page.dart';
import 'package:bandon/screens/lodging.dart';
import 'package:bandon/screens/news.dart';
import 'package:bandon/screens/things-to-do.dart';
import 'package:bandon/screens/relocate_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:flutter/services.dart';

import '../app.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({Key key}) : super(key: key);

  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  bool _locationEnabled = false;

  bool _getDarkModeStatus(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? true : false;
  void _toggleTheme(AppState appState) => appState.toggleTheme();

  @override
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
    var _result = false;
    final _permission = await Geolocator.checkPermission();

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
        print("Couldn't determine location permissions");
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
    final appState = context.findAncestorStateOfType<AppState>();

    return Drawer(
        child: ListView(
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xFF05668D),
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
          color: const Color(0xFF05668D),
          child: Column(
            children: [
              ListTile(
                dense: true,
                title: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(HomePage.routeName),
              ),
              ListTile(
                dense: true,
                title: const Text(
                  'Start Here',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(GetStartedScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: const Text(
                  'Dining',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(DiningScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: const Text(
                  'Lodging',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(LodgingScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: const Text(
                  'Things To Do',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(ThingsToDoScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: const Text(
                  'Events',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(EventsScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: const Text(
                  'Find a Business',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () => Navigator.of(context)
                    .pushNamed(FindBusinessScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: const Text(
                  'News',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(NewsScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: const Text(
                  'Contact',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(ContactScreen.routeName),
              ),
              ListTile(
                dense: true,
                title: const Text(
                  'Relocate Here',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(RelocateScreen.routeName),
              ),
              SwitchListTile(
                secondary: Icon(Icons.location_on),
                title: const Text(
                  'Location access',
                  style: TextStyle(color: Colors.white),
                ),
                isThreeLine: true,
                value: _locationEnabled,
                onChanged: null,
                subtitle: InkWell(
                  child: const Text(
                    'Tap here to review your device settings',
                    style: TextStyle(color: Colors.white70),
                  ),
                  onTap: () {
                    Geolocator.openAppSettings();
                  },
                ),
              ),
              SwitchListTile(
                secondary: Icon(Icons.settings_brightness),
                title: const Text(
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
