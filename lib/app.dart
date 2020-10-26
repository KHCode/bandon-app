import 'package:bandon/screens/relocate_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/services.dart';

import 'screens/contact.dart';
import 'screens/dining.dart';
import 'screens/events.dart';
import 'screens/find-business.dart';
import 'screens/getting-started.dart';
import 'screens/home_page.dart';
import 'screens/lodging.dart';
import 'screens/onboarding.dart';
import 'screens/things-to-do.dart';
import 'screens/relocate_screen.dart';

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

  static final routes = {
    ContactScreen.routeName: (context) => ContactScreen(),
    DiningScreen.routeName: (context) => DiningScreen(),
    EventsScreen.routeName: (context) => EventsScreen(),
    FindBusinessScreen.routeName: (context) => FindBusinessScreen(),
    GetStartedScreen.routeName: (context) => GetStartedScreen(),
    LodgingScreen.routeName: (context) => LodgingScreen(),
    ThingsToDoScreen.routeName: (context) => ThingsToDoScreen(),
    RelocateScreen.routeName: (context) => RelocateScreen()
  };

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
        routes: routes);
  }
}
