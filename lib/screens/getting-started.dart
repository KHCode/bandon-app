import 'package:bandon/widgets/padded_text_body.dart';
import 'package:bandon/widgets/styled_expansion_tile.dart';
import 'package:bandon/widgets/styled_section_banner.dart';
import 'package:bandon/widgets/styled_top_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/settings_drawer.dart';
import '../widgets/app_gradient_background.dart';
import '../widgets/styled_top_banner.dart';
import '../widgets/styled_section_banner.dart';
import '../widgets/styled-dropdown-menu.dart';

class GetStartedScreen extends StatelessWidget {
  static const routeName = 'gettingStartedScreen';

  static const bodyIntro = [
    'The nearest international airports are Portland (PDX), Medford (MFR) and San Francisco (SFO). Portland, Oregon, is approximately 250 north of Bandon, and drive time is four to five hours. Medford, Oregon, is approximately 165 miles southeast of Bandon, and drive time is about three hours. San Francisco, California, is approximately 450 miles south of Bandon, and drive time is eight to nine hours.',
  ];

  static const bodyFlight = [
    'Eugene Airport (EUG) in Eugene, Oregon offers flights from multiple destinations with several airlines, including United, Delta, Alaska, and American Airlines. Eugene is a two and a half hour drive from Bandon, approximately 150 miles.',
    'Southwestern Oregon Regional Airport (OTH) in North Bend offers commercial flights via United between San Francisco, CA, and Denver, CO. OTH is located 30 miles north of Bandon.',
    'Bandon State Airport (BDY) in Bandon offers private and charter plane service.',
    'Click on our Bandon Quick Look links below for additional travel and transportation tips. (links open up a browser)',
  ];

  static const transpOptions = [
    'Bandon State Airport',
    'Southwestern Oregon Regional Airport',
    'Eugene Airport',
    'Amtrak',
    'Driver on Demand',
    'Coos County Area Transit',
    'Coastal Express'
  ];

  static const transpLinks = [
    'https://www.linearair.com/airport/Bandon-State-in-Bandon-OR-BDY/',
    'https://cooscountyairportdistrict.com/',
    'https://www.eugene-or.gov/173/Airport',
    'https://www.amtrak.com/content/amtrak/en-us/stations/eug.html',
    'https://driverondemand.online/',
    'https://www.coostransit.org/',
    'https://currypublictransit.org/coastal-express/'
  ];

  static const bodyDrive = [
    'When you plan your drive to the Southern Oregon Coast, look forward to the memorable scenery along the way. Browse the suggested routes below.',
  ];

  static const driveDisplays = [
    'West Coast Drives',
    'Portland',
    'Eugene',
    'Bend',
    'Ashland',
    'San Francisco',
    'Boise',
  ];

  static const driveValues = [
    'start',
    'Portland, OR',
    'Eugene, OR',
    'Bend, OR',
    'Ashland, OR',
    'San Francisco, CA',
    'Boise, ID',
  ];

  static const goCasual = [
    'Unless you plan to attend a wedding or special event, you can leave your formal wear at home. Our shop owners and restauranteurs want you to feel comfortable on the beach or sitting down to dinner.',
  ];

  static const packLayers = [
    'Bandon’s climate is temperate. But, temperatures can vary by several degrees between waterfront and inland destinations. Don’t let a little morning fog or cloud cover fool you. Wear a hat or sunscreen to protect your skin from sunburn.',
  ];

  static const dogsWelcome = [
    'Dogs are welcome on our beaches, and many of our retail shops are pet friendly. Bandon does have a leash law, so remember to bring a leash and keep your pet secure. Our chamber business members are familiar with ADA regulations and welcome service animals in areas where customers are allowed.',
  ];

  static const bookEarly = [
    'Book your lodging early to get the best selection. Bandon area hotels, vacation rentals and camp grounds are regularly full throughout the summer and winter holidays.',
  ];

  static const extendedTravel = [
    'The Bandon Visitors Center provides information about vacation destinations near Bandon, in the Southwestern Oregon region and the Oregon Coast. Find additional Oregon travel resources from our partners at the Oregon Coast Visitors Association and Travel Oregon.',
  ];

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandon Start Here'),
      ),
      endDrawer: const SettingsDrawer(),
      body: Container(
        decoration: gradientBackground(context),
        child: ListView(
          children: <Widget>[
            StyledTopBanner(
              topText: 'Getting to',
              bottomText: 'Bandon',
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Image.asset('assets/images/bandon-forest-generic.jpg'),
            ),
            const PaddedTextBody(
              textBody: bodyIntro,
            ),
            const StyledSectionBanner(
              leftText: 'Take a Train',
              rightText: 'or a Plane',
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Image.asset('assets/images/plane-view.jpg'),
            ),
            const PaddedTextBody(
              textBody: bodyFlight,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: transpOptions.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: GestureDetector(
                      onTap: () => _launchURL(transpLinks[index]),
                      child: Card(
                        color: Color(0xFFF58B3E),
                        child: Container(
                          child: Center(
                            child: Text(
                              transpOptions[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Color(0xFF05668d), fontSize: 24.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 20),
              child: Image.asset('assets/images/separator-suitcase.png'),
            ),
            const StyledSectionBanner(
              leftText: 'Take a Scenic',
              rightText: 'Drive',
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Image.asset('assets/images/drive-view.jpg'),
            ),
            const PaddedTextBody(
              textBody: bodyDrive,
            ),
            StyledDropdownMenu(
              optionsDisplays: driveDisplays,
              optionsValues: driveValues,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 20),
              child: Image.asset('assets/images/separator-suitcase.png'),
            ),
            const StyledSectionBanner(
              leftText: 'Planning a trip',
              rightText: 'to Bandon?',
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: StyledExpansionTile(
                title: 'Go Casual',
                hiddenContent: goCasual,
              ),
            ),
            const StyledExpansionTile(
              title: 'Pack Layers',
              hiddenContent: packLayers,
            ),
            const StyledExpansionTile(
              title: 'Dogs are Welcome',
              hiddenContent: dogsWelcome,
            ),
            const StyledExpansionTile(
              title: 'Book Early',
              hiddenContent: bookEarly,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: StyledExpansionTile(
                title: 'Extended Travel in Oregon',
                hiddenContent: extendedTravel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
