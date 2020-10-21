import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/services.dart';

import 'screens/home_page.dart';
import 'screens/onboarding.dart';

class App extends StatefulWidget {
  final String title;
  final SharedPreferences prefs;

  const App({Key key, @required this.title, @required this.prefs})
      : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  static const ONBOARDED_KEY = 'hasBeenOnboarded';

  bool get _onboarded => widget.prefs.getBool(ONBOARDED_KEY) ?? false;

  Widget get _startingPage => _onboarded
      ? HomePage(title: widget.title)
      : OnboardingPage(
          title: widget.title, prefs: widget.prefs, prefsKey: ONBOARDED_KEY);

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _startingPage,
    );
  }
}
