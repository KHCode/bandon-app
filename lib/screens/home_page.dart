import 'package:flutter/material.dart';
// import 'package:weather/weather.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/settings_drawer.dart';
import '../widgets/test_distance_display.dart';
import '../widgets/test_rss_feed.dart';
import '../widgets/test_web_scraping.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF05668d), Color(0xFFf0f3bd)],
          ),
        ),
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Image.asset('assets/images/bandon-logo.png'),
          ),
          Image.asset('assets/images/beach-sunset.jpg'),
          Image.asset('assets/images/bandon-weather-widget.jpg'),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'About Bandon Oregon',
              style: GoogleFonts.roboto(),
            ),
          )
        ]),
      ),
      endDrawer: SettingsDrawer(),
    );
  }
}
