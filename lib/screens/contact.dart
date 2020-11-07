import 'package:bandon/widgets/padded_text_body.dart';
import 'package:bandon/widgets/styled_section_banner.dart';
import 'package:bandon/widgets/styled_top_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/settings_drawer.dart';
import '../widgets/app_gradient_background.dart';
import '../widgets/contact-form.dart';

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
          PaddedTextBody(
            textBody: [
              'Contact us with questions about volunteering and visiting or relocating  to Bandon.',
            ],
          ),
          ContactForm(),
        ]),
      ),
    );
  }
}
