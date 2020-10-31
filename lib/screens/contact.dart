import 'package:bandon/widgets/styled_section_banner.dart';
import 'package:bandon/widgets/styled_top_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/settings_drawer.dart';
import '../widgets/app_gradient_background.dart';

class ContactScreen extends StatelessWidget {
  static const routeName = 'contactScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bandon Contact"),
      ),
      endDrawer: SettingsDrawer(),
      body: Container(
        decoration: gradientBackground(context),
        child: ListView(children: <Widget>[
          StyledTopBanner(
            topText: "Contact Us",
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Image.asset('assets/images/bandon-seagull-generic.jpg'),
          ),
          StyledSectionBanner(
            leftText: "Coming",
            rightText: "Soon",
          ),
        ]),
      ),
    );
  }
}
