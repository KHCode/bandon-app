import 'package:bandon/widgets/padded_text_body.dart';
import 'package:bandon/widgets/styled_section_banner.dart';
import 'package:bandon/widgets/styled_top_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/settings_drawer.dart';
import '../widgets/app_gradient_background.dart';
import '../widgets/contact-form.dart';

class ContactScreen extends StatelessWidget {
  static const routeName = 'contactScreen';

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Uri streetAddressLaunchUri = Uri.https('google.com', '/maps/search/', {
    'api': '1',
    'query': '300 2nd St SE, Bandon, OR',
  });

  final String _phoneNumber = '541-347-9616';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandon Contact'),
      ),
      endDrawer: SettingsDrawer(),
      body: Container(
        decoration: gradientBackground(context),
        child: ListView(children: <Widget>[
          StyledTopBanner(
            topText: 'Contact Us',
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Image.asset('assets/images/bandon-seagull-generic.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
            child: Text(
              'Contact us with questions about volunteering and visiting or relocating  to Bandon.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          GestureDetector(
            onTap: () => _launchURL(streetAddressLaunchUri.toString()),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
              child: Text(
                '300 2nd Street\nPO Box 1515\nBandon, OR 97411',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _launchURL('tel:$_phoneNumber'),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
              child: Text(
                '$_phoneNumber',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
