import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/styled_section_banner.dart';
import '../widgets/styled_top_banner.dart';
import '../widgets/app_gradient_background.dart';
import '../widgets/padded_text_body.dart';
import '../widgets/settings_drawer.dart';

class ThingsToDoScreen extends StatefulWidget {
  static const routeName = 'thingsToDoScreen';

  @override
  _ThingsToDoScreenState createState() => _ThingsToDoScreenState();
}

class _ThingsToDoScreenState extends State<ThingsToDoScreen> {
  static const body1 = [
    'How you pace yourself in Bandon is entirely up to you. We pride ourselves on a small-town attitude that’s relaxed and unhurried.',
    'Toss a crab pot in the water, and then kick back on the dock. Or, stroll through Old Town– then head back to the water to see what’s bitin’.',
    'If it’s excitement you crave, our ocean-going and river fishing guides will give you a workout. Or, grab a fat tire bike and hit the trail for a two-wheeled challenge.',
    'Many of our favorite attractions feature the great outdoors. Always breathtaking, always open.',
    'Of course, Bandon also offers great shopping, plus arts and cultural experiences.',
    'We’re confident you’ll find fun things to do with the whole family.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bandon Things To Do"),
      ),
      endDrawer: SettingsDrawer(),
      body: Container(
        decoration: gradientBackground(),
        child: ListView(
          children: <Widget>[
            StyledTopBanner(topText: "Things To Do"),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Image.asset(
                  'assets/images/things-to-do/bandon-things-to-do.jpg'),
            ),
            PaddedTextBody(textBody: body1),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Image.asset('assets/images/separator.png'),
            ),
            StyledTopBanner(
              topText: "Golf on the",
              bottomText: "Southern Oregon Coast",
              fontSize: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child:
                  Image.asset('assets/images/things-to-do/bandon-golfing.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Image.asset('assets/images/separator-golf.png'),
            ),
            StyledTopBanner(
              topText: "Cycle and Hike",
              fontSize: 36,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child:
                  Image.asset('assets/images/things-to-do/bandon-hiking.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}
