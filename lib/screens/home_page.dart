import 'package:flutter/material.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              const Text(
                'Welcome!',
                style: TextStyle(fontSize: 28.0),
              ),
              TestDistanceDisplay(),
              const Padding(padding: EdgeInsets.only(top: 700.0)),
              TestRssFeed(),
              TestWebScraping()
            ],
          ),
        ),
      ),
      endDrawer: SettingsDrawer(),
    );
  }
}
