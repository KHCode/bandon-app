import 'package:bandon/widgets/padded_text_body.dart';
import 'package:bandon/widgets/styled_section_banner.dart';
import 'package:bandon/widgets/styled_top_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/settings_drawer.dart';
import '../widgets/app_gradient_background.dart';
import '../widgets/padded_text_body.dart';

class RelocateScreen extends StatelessWidget {
  static const routeName = 'relocateScreen';

  static const bodyRelocate = [
    'If you’re looking to make the Oregon Coast your home, Bandon welcomes you!',
    'We invite you to join the countless Bandon residents who say they came to Bandon for vacation and fell in love. Those who choose to move here appreciate Bandon’s beauty, clean air, moderate climate and friendly people.',
    'Whether you’re ready to move now, or considering future relocation, here are tips to help you get started.',
  ];

  static const relocatePacket = [
    'Stop by the Bandon Chamber Visitors Center, or submit the electronic information request form on our Contact page.',
  ];

  static const localRealtor = [
    'We know you can search RMLS listings on your own, but our member realtors are experts when it comes to helping new residents choose the right property, in the best location and price point for you.',
  ];

  static const moveBusiness = [
    'Visit the Member Resources page of our Members section for a list of state and local contacts to help with business relocation or start-up.',
  ];

  static const findRental = [
    'If you’ve just moved to Bandon and need a place to stay, read Tips for Finding a Rental.',
  ];

  static const findJob = [
    'Search job listings at WorkSource Oregon.',
    'Check job posts published in the World News, Bandon Western World and Coffee Break, in circulation and online at The World.',
  ];

  static const finServ = [
    'Find local banks, accounting and services.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandon Relocate'),
      ),
      endDrawer: SettingsDrawer(),
      body: Container(
        decoration: gradientBackground(context),
        child: ListView(
          children: <Widget>[
            StyledTopBanner(
              topText: 'Relocate',
              bottomText: 'to Bandon',
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Image.asset('assets/images/bandon-sunset-generic.jpg'),
            ),
            const PaddedTextBody(
              textBody: bodyRelocate,
              top: 15,
              bottom: 0,
            ),
            StyledSectionBanner(
              leftText: 'Request a',
              rightText: 'Relocation Packet',
              fontSize: 28,
            ),
            const PaddedTextBody(
              textBody: relocatePacket,
              top: 30,
              bottom: 0,
            ),
            StyledSectionBanner(
              leftText: 'Contact a',
              rightText: 'Local Realtor',
            ),
            const PaddedTextBody(
              textBody: localRealtor,
              top: 30,
              bottom: 0,
            ),
            StyledSectionBanner(
              leftText: 'Move Your Business,',
              rightText: 'or Start a New One',
              fontSize: 22,
            ),
            const PaddedTextBody(
              textBody: moveBusiness,
              top: 30,
              bottom: 0,
            ),
            StyledSectionBanner(
              leftText: 'Find',
              rightText: 'a Rental',
            ),
            const PaddedTextBody(
              textBody: findRental,
              top: 30,
              bottom: 0,
            ),
            StyledSectionBanner(
              leftText: 'Find',
              rightText: 'a Job',
            ),
            const PaddedTextBody(
              textBody: findJob,
              top: 30,
              bottom: 0,
            ),
            StyledSectionBanner(
              leftText: 'Transfer',
              rightText: 'Financial Services',
              fontSize: 28,
            ),
            const PaddedTextBody(
              textBody: finServ,
              top: 30,
            ),
          ],
        ),
      ),
    );
  }
}
