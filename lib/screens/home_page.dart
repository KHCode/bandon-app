import 'package:bandon/widgets/styled_section_banner.dart';

import '../widgets/app_gradient_background.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:weather/weather.dart';

import 'dining.dart';
import 'lodging.dart';
import '../widgets/settings_drawer.dart';
import '../widgets/padded_text_body.dart';

// Week 4 tests
// import '../widgets/test_distance_display.dart';
// import '../widgets/test_rss_feed.dart';
// import '../widgets/test_web_scraping.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  final String title;

  HomePage({Key key, @required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const bodyAbout = [
    'Life in Bandon is shaped by nature and the people who make their home in this corner of the Oregon Coast.',
    'That’s why we say our attractions are always in season, always open.',
    'Stunning ocean vistas. Wild woods and streams. Friendly neighbors who understand you want to pace yourself, take it all in.',
    'Enjoy year-round fishing, cycling, golf, hiking and beach going. Our landscapes are green. Our air is clean, and the temps are moderate all year. If the wind picks up, just bundle up– and experience some of the most dramatic storm watching in Oregon.',
    'If you’re planning a visit to Bandon, you’ve found our home on the web. Feel free to contact us for more information. The Bandon Chamber of Commerce and Visitors Center office is open daily',
  ];

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
        decoration: gradientBackground(context),
        child: ListView(children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
              child: Image.asset(
                  'assets/images/bandon-logo-${Theme.of(context).brightness == Brightness.dark ? 'light' : 'dark'}.png')),
          Image.asset('assets/images/beach-sunset.jpg'),
          Image.asset('assets/images/bandon-weather-widget.jpg'),
          StyledSectionBanner(
            leftText: 'About',
            rightText: 'Bandon Oregon',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Image.asset('assets/images/separator.png'),
          ),
          PaddedTextBody(textBody: bodyAbout),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset(
                'assets/images/bandon-home-plan-your-visit-alt.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: InkWell(
              child: Image.asset(
                  'assets/images/bandon-home-choose-your-table-green.jpg'),
              onTap: () =>
                  Navigator.of(context).pushNamed(DiningScreen.routeName),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: InkWell(
              child:
                  Image.asset('assets/images/bandon-home-book-your-stay.jpg'),
              onTap: () =>
                  Navigator.of(context).pushNamed(LodgingScreen.routeName),
            ),
          ),
        ]),
      ),
      endDrawer: SettingsDrawer(),
    );
  }
}
