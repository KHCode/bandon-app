import 'package:flutter/material.dart';

import '../widgets/settings_drawer.dart';
import '../widgets/test_distance_display.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 28.0),
            ),
            TestDistanceDisplay(),
          ],
        ),
      ),
      endDrawer: SettingsDrawer(),
    );
  }
}
