import 'package:flutter/material.dart';

import '../screens/find_business.dart';
import '../widgets/styled_section_banner.dart';
import '../widgets/styled_top_banner.dart';
import '../widgets/app_gradient_background.dart';
import '../widgets/padded_text_body.dart';
import '../widgets/settings_drawer.dart';

class DiningScreen extends StatelessWidget {
  static const routeName = 'diningScreen';

  const DiningScreen({Key key}) : super(key: key);

  static const body1 = [
    'We invite you to sample the foods and flavors of Bandon and the coast. Bandon chefs have year-round access to local and regionally sourced seafood, as well as meats, produce and cheese.',
    'Taste Oregon wine, and regional craft beer and spirits.',
    'Casual fine dining is the watchword in Bandon. Our chefs and servers welcome diners to come as they are after a walk on the beach or the golf course.'
  ];
  static const body2 = [
    'Start your day with a hot cup of coffee and fresh baked goodies at Bandon Baking Company or Bandon Coffee Café. Sunday brunch at Lord Bennett’s is always memorable– generous menu options and a bird’s eye view of the beach at Face Rock. The Station Restaurant serves classic diner style breakfast.',
    'For a midday meal that’s distinctly Bandon, relax at a sidewalk table at the Bandon Fish Market, Foley’s Irish Pub or Tony’s Crab Shack. Local grocery markets and delis offer quick dine-in or takeout options.',
    'Old Town dinner spots include Alloro Wine Bar and Restaurant, Edgewaters, and The Wheelhouse. Beyond Old Town, choose a table at Lord Bennett’s Restaurant or Billy Smoothboars Sports Bar and Restaurant, or any of the restaurants at Bandon Dunes Golf Resort. If you’re out late, check out Broken Anchor Bar and Grill.'
  ];
  static const body3 = [
    'Indulge your taste buds with sweets unique to our corner of the coast. Coastal Mist Chocolate Boutique has won countless awards– one bite, and you’ll see why their classic chocolates and desserts have fans raving. Find award-winning artisan cheese at Face Rock Creamery. The creamery retail shop also features a variety of Oregon-made food and wine.',
    'Sample local brews on tap Bandon Brewing. For more local specialty foods, visit the Big Wheel General Store and try their handmade fudge served right from the baking pan. Cranberry Sweets is an Oregon Coast sweet shop that celebrates locally grown cranberries, and a lot more. Misty Meadows, south of town, is your destination for Oregon-grown berries, preserves and sauces.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandon Dining'),
      ),
      endDrawer: SettingsDrawer(),
      body: Container(
          decoration: gradientBackground(context),
          child: ListView(
            children: <Widget>[
              const StyledTopBanner(topText: 'Choose Your Table'),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child:
                    Image.asset('assets/images/dining/bandon-fish-market.jpg'),
              ),
              const PaddedTextBody(textBody: body1),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 50.0),
                child: Image.asset('assets/images/separator-cranberry.png'),
              ),
              const StyledSectionBanner(
                leftText: 'Three',
                rightText: 'Squares',
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Image.asset(
                  'assets/images/dining/shrimp.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              const PaddedTextBody(textBody: body2),
              const StyledSectionBanner(
                  leftText: 'Coastal', rightText: 'Treats'),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Image.asset(
                  'assets/images/dining/dessert.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              const PaddedTextBody(textBody: body3),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                    FindBusinessScreen.routeName,
                    arguments: 'Restaurants'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Image.asset(
                      'assets/images/dining/dining-restaurants.jpg'),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                    FindBusinessScreen.routeName,
                    arguments: 'Specialty Food Sellers'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child:
                      Image.asset('assets/images/dining/dining-specialty.jpg'),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                    FindBusinessScreen.routeName,
                    arguments: 'Wine, Beer & Sprits'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child:
                      Image.asset('assets/images/dining/dining-wine-beer.jpg'),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                    FindBusinessScreen.routeName,
                    arguments: 'All Dining'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Image.asset('assets/images/dining/all-dining.jpg'),
                ),
              ),
            ],
          )),
    );
  }
}
