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
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 40),
            child: Text(
              'About Bandon Oregon',
              style: GoogleFonts.roboto(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Image.asset('assets/images/separator.png'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
            child: Text(
              'Life in Bandon is shaped by nature and the people who make their home in this corner of the Oregon Coast.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
            child: Text(
              'That’s why we say our attractions are always in season, always open.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
            child: Text(
              'Stunning ocean vistas. Wild woods and streams. Friendly neighbors who understand you want to pace yourself, take it all in.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
            child: Text(
              'Enjoy year-round fishing, cycling, golf, hiking and beach going. Our landscapes are green. Our air is clean, and the temps are moderate all year. If the wind picks up, just bundle up– and experience some of the most dramatic storm watching in Oregon.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
            child: Text(
              'If you’re planning a visit to Bandon, you’ve found our home on the web. Feel free to contact us for more information. The Bandon Chamber of Commerce and Visitors Center office is open daily',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset(
                'assets/images/bandon-home-plan-your-visit-alt.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset(
                'assets/images/bandon-home-choose-your-table-green.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset('assets/images/bandon-home-book-your-stay.jpg'),
          ),
        ]),
      ),
      endDrawer: SettingsDrawer(),
    );
  }
}
