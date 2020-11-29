import 'package:flutter/material.dart';

import '../screens/find-business.dart';
import '../widgets/styled_button.dart';
import '../widgets/styled_top_banner.dart';
import '../widgets/app_gradient_background.dart';
import '../widgets/padded_text_body.dart';
import '../widgets/settings_drawer.dart';

class LodgingScreen extends StatelessWidget {
  static const routeName = 'lodgingScreen';
  LodgingScreen({Key key}) : super(key: key);

  static const body1 = [
    '''Your Bandon stay can be as relaxed or posh as you like.
\nStart your day with the sounds of the surf and watch the sunset over the Pacific as you wind down in the evening. Choose from hotels, motels and vacation rentals featuring river and ocean views, even direct beach access.
\nVisitors can bunk within walking distance of Old Town shops and restaurants. Or, plan a retreat in a wooded valley or hilltop hideaway.
\nMany of our Bandon Chamber lodging members offer stay-and-play packages and seasonal specials.
\nLooking for special accommodations or amenities? Pet-friendly, ADA accessible, large groups? Let us help you find the right destination.'''
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bandon Lodging'),
      ),
      endDrawer: const SettingsDrawer(),
      body: Container(
        decoration: gradientBackground(context),
        child: ListView(
          children: <Widget>[
            StyledTopBanner(topText: 'Book a Room'),
            Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child:
                    Image.asset('assets/images/lodging-wildspring-cabin.jpg')),
            PaddedTextBody(textBody: body1),
            StyledButton(
              text: 'View Lodging Options',
              onPressed: () => Navigator.of(context).pushNamed(
                FindBusinessScreen.routeName,
                arguments: 'Lodging',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
