import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/business_details.dart';
import 'screens/contact.dart';
import 'screens/dining.dart';
import 'screens/event_details.dart';
import 'screens/events.dart';
import 'screens/find_business.dart';
import 'screens/getting_started.dart';
import 'screens/home_page.dart';
import 'screens/lodging.dart';
import 'screens/news.dart';
import 'screens/onboarding.dart';
import 'screens/relocate_screen.dart';
import 'screens/things_to_do.dart';

import 'utils/business_collector.dart';
import 'utils/event_collector.dart';

class App extends StatefulWidget {
  final String title;
  final SharedPreferences prefs;
  final eventCollector =
      const EventCollector(url: 'https://tourism.bandon.com/events');
  final businessCollector =
      const BusinessCollector(url: 'https://tourism.bandon.com/list');

  const App({Key key, @required this.title, @required this.prefs})
      : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  static const ONBOARDED_KEY = 'hasBeenOnboarded';
  static const DARK_MODE_KEY = 'darkMode';
  static const EVENT_UPDATE_TIME_KEY = 'lastEventUpdateTime';
  static const BUSINESS_UPDATE_TIME_KEY = 'lastBusinessUpdateTime';
  static const BUSINESS_URL_UPDATE_TIME_KEY = 'lastBusinessUrlUpdateTime';
  static const EVENT_UPDATE_TIME_KEY_DEPRECATED = 'lastUpdateTime';

  static final routes = {
    BusinessDetails.routeName: (context) => BusinessDetails(),
    ContactScreen.routeName: (context) => ContactScreen(),
    DiningScreen.routeName: (context) => DiningScreen(),
    EventDetails.routeName: (context) => EventDetails(),
    EventsScreen.routeName: (context) => EventsScreen(),
    FindBusinessScreen.routeName: (context) => FindBusinessScreen(),
    GetStartedScreen.routeName: (context) => GetStartedScreen(),
    LodgingScreen.routeName: (context) => LodgingScreen(),
    NewsScreen.routeName: (context) => NewsScreen(),
    RelocateScreen.routeName: (context) => RelocateScreen(),
    ThingsToDoScreen.routeName: (context) => ThingsToDoScreen(),
  };

  Brightness _appBrightness;

  bool get _darkMode => widget.prefs.getBool(DARK_MODE_KEY) ?? false;
  bool get _onboarded => widget.prefs.getBool(ONBOARDED_KEY) ?? false;

  Widget get _startingPage => _onboarded
      ? HomePage(title: widget.title)
      : OnboardingPage(
          title: widget.title, prefs: widget.prefs, prefsKey: ONBOARDED_KEY);

  @override
  void initState() {
    super.initState();
    _appBrightness = _darkMode ? Brightness.dark : Brightness.light;
    _getEventsOnLoad();
    _getBusinessesOnLoad();
  }

  void _getEventsOnLoad() async {
    if (widget.prefs.containsKey(EVENT_UPDATE_TIME_KEY_DEPRECATED)) {
      await widget.prefs.remove(EVENT_UPDATE_TIME_KEY_DEPRECATED);
    }
    final lastUpdate = widget.prefs.getString(EVENT_UPDATE_TIME_KEY) ??
        DateTime.now().toUtc().subtract(Duration(minutes: 120)).toString();
    final difference =
        DateTime.now().toUtc().difference(DateTime.parse(lastUpdate));
    // If events were updated in last hour, don't try to update again.
    if (difference.inMinutes.abs() > 60) {
      // Otherwise get events, verify success and then update the last time
      // events were fetched.
      if (await widget.eventCollector.getEvents()) {
        print('Events fetched successfully');
        await widget.prefs.setString(
            EVENT_UPDATE_TIME_KEY, DateTime.now().toUtc().toString());
      } else {
        print('Failed to fetch events');
      }
    } else {
      print('Events were fetched recently. Skipping update.');
    }
  }

  void _getBusinessesOnLoad() async {
    // Set the last time the list of valid business URLs was fetched to the
    // current time if businesses haven't been fetched yet, since we'll use our
    // hardcoded, known good list so we can immediately start populating the
    // database.
    final lastUrlListUpdate =
        widget.prefs.getString(BUSINESS_URL_UPDATE_TIME_KEY) ??
            DateTime.now().toUtc().toString();
    // Set the last time business data was fetched to a time in the past if
    // the process of populating the database hasn't completed yet.
    final lastBusinessUpdate =
        widget.prefs.getString(BUSINESS_UPDATE_TIME_KEY) ??
            DateTime.now().toUtc().subtract(Duration(days: 31)).toString();

    final urlListUpdateDifference =
        DateTime.now().toUtc().difference(DateTime.parse(lastUrlListUpdate));
    final businessUpdateDifference =
        DateTime.now().toUtc().difference(DateTime.parse(lastBusinessUpdate));

    // If businesses were updated in last 30 days and we have a complete list
    // (over 200 businesses), don't try to update again.
    // Otherwise, get businesses, verify success and then update the last time
    // businesses were fetched.
    if (businessUpdateDifference.inDays.abs() > 30 ||
        await widget.businessCollector.countBusinesses() < 200) {
      final initialUrlList = <String>[];
      if (urlListUpdateDifference.inDays.abs() < 30) {
        // Load the initial list of valid URLs for businesses, so we don't waste
        // time gathering URLs before scraping data when the database is empty
        const URL_LIST_PATH = 'assets/initialBusinessUrls.txt';
        final urlsString = await rootBundle.loadString(URL_LIST_PATH);
        initialUrlList.addAll(urlsString.split(';'));
      }

      if (await widget.businessCollector.getBusinesses(initialUrlList)) {
        print('Businesses fetched successfully');
        await widget.prefs.setString(
            BUSINESS_UPDATE_TIME_KEY, DateTime.now().toUtc().toString());
        // Update the last time we fetched valid business URLs if the initial
        // business list we passed was empty.
        if (initialUrlList?.isEmpty ?? true) {
          await widget.prefs.setString(
              BUSINESS_URL_UPDATE_TIME_KEY, DateTime.now().toUtc().toString());
        }
      } else {
        print('Failed to fetch businesses');
      }
    } else {
      print('Businesses were fetched recently. Skipping update.');
    }
  }

  void toggleTheme() {
    widget.prefs.setBool(DARK_MODE_KEY, !_darkMode);
    setState(() {
      _appBrightness = _darkMode ? Brightness.dark : Brightness.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData(
        brightness: _appBrightness,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _startingPage,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
