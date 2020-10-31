import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_gradient_background.dart';
import '../widgets/settings_drawer.dart';
import '../widgets/styled_section_banner.dart';
import '../widgets/styled_top_banner.dart';

class FindBusinessScreen extends StatelessWidget {
  static const routeName = 'findBusinessScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bandon Find a Business"),
      ),
      endDrawer: SettingsDrawer(),
      body: Container(
        decoration: gradientBackground(context),
        child: ListView(children: <Widget>[
          StyledTopBanner(
            topText: "Find a Business",
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Image.asset('assets/images/bandon-mussels-generic.jpg'),
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
