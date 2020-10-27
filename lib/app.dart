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

import 'utils/event_collector.dart';

class App extends StatefulWidget {
  final String title;
  final SharedPreferences prefs;
  final eventCollector =
      const EventCollector(url: 'https://tourism.bandon.com/events');

  const App({Key key, @required this.title, @required this.prefs})
      : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  static const ONBOARDED_KEY = 'hasBeenOnboarded';
  static const EVENT_UPDATE_TIME_KEY = 'lastUpdateTime';

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
    getEventsOnLoad();
  }

  void getEventsOnLoad() async {
    String lastUpdate = widget.prefs.getString(EVENT_UPDATE_TIME_KEY) ??
        DateTime.now().subtract(Duration(minutes: 120)).toString();
    Duration difference = DateTime.now().difference(DateTime.parse(lastUpdate));
    // If events were updated in last hour, don't try to update again.
    if (difference.inMinutes.abs() > 60) {
      // Otherwise get events, verify success and then update the last time
      // events were fetched.
      if (await widget.eventCollector.getEvents()) {
        print('Events fetched successfully');
        widget.prefs
            .setString(EVENT_UPDATE_TIME_KEY, DateTime.now().toString());
      } else {
        print('Failed to fetch events');
      }
    } else {
      print('Events were fetched recently. Skipping update.');
    }
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
