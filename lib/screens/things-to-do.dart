import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/styled_section_banner.dart';
import '../widgets/styled_top_banner.dart';
import '../widgets/app_gradient_background.dart';
import '../widgets/padded_text_body.dart';
import '../widgets/settings_drawer.dart';
import '../widgets/styled_expansion_tile.dart';

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

  static const bodyBeach = [
    'Our beaches are among Bandon’s most popular destinations.',
    'All Oregon beaches are public. And, you can find multiple access points right in Bandon.',
    'Each season, the weather and tides reshape the sandy landscape. Migratory birds and marine mammals make their annual stopover: sea stacks, tide pools, sand and water are home to countless varieties of wildlife.',
    'With so much to see and explore, we invite you to take your time.',
    'What will you discover?',
  ];

  static const bodyFishing = [
    'One of the greatest things about sport fishing in the Bandon area is that there’s something going on all year long, according to avid fisherman, columnist and local bait shop owner Tony Roszkowski.',
    'Tony knows his fish– he’s been in the bait, tackle and seafood business in Bandon for more than 30 years.',
  ];

  static const bodyBirding = [
    'Bandon attracts birdwatchers throughout the year, especially those eager for a glimpse of Pacific shorebirds. Beaches, rivers and intertidal marshes near Bandon provide inviting nesting grounds, or migratory resting space, for a wide variety of birdlife.',
    'Just within the Bandon Marsh and Ni-les’tun wildlife refuges, birders can observe multiple species of shorebirds, waterfowl, songbirds and birds of prey.',
  ];

  static const linksStyleGolf = [
    'The links golf tradition is alive and well in Bandon. Firm turf, ocean breezes and rolling dunes invite golfers to challenge their expectations. On the Southern Oregon Coast, fairways and bunkers are shaped by nature, surrounded by acres of shoreline vegetation.',
    'And, they’re designed by course architects who value restraint. No imported sand. No condos in the background. Just the terrain and the game. It’s a synergy of nature and nurture, and golfers are eager for more.'
  ];

  static const publicCourses = [
    'Locals and visiting golfers can choose from multiple award-winning courses at Bandon Dunes Golf Resort and Bandon Crossings Golf Course. Both businesses are open year-round.',
    'Advance booking recommended.'
  ];

  static const golfEvents = [
    'Young golfers tee off early in Bandon. Students in youth golf programs play award winning greens with pro instructors at Bandon Crossings Golf Course and Bandon Dunes Golf Resort.',
    'Programs are designed for novice and experienced players. Watch the event calendar, or contact Bandon Dunes or Bandon Crossings for event dates and details.',
  ];

  static const goWild = [
    'Easy access to wild places makes Bandon unique in the 21st century.',
    'Public beaches, parks, wildlife reserves, bikeways and trails offer countless destinations for outdoor enthusiasts.',
    'Though some may opt for truly deep woods exploration, many parks and trails are only a short drive from town. Even a quick jaunt along a quiet stretch of beach, or forest trail, can give the impression that you’re light years from your typical routine.',
    'Grab your water bottle, camera or binoculars, and enjoy the region’s year-round natural wonder.',
  ];

  static const cyclistLayover = [
    'Rest up and restock in Bandon. Cyclists traveling the Oregon Coast will find all the amenities for the perfect layover.',
    'Bandon has bike-friendly resources. And, the compact geography makes it easy to get around by foot or bike.',
    'New installations make cyclists feel even more welcome: A cyclist section was unveiled at Bullards Beach State Park in 2014 for overnight stays. For a quick rest, park at the cycle stop on First St. in Old Town, next to Tony’s Crab Shack, then walk to nearby beaches, waterfront, shopping and dining locations.',
    'Stroll the beach. Relax. Upload your latest pics. No matter how you spend your time in Bandon, you’ll hit the road refreshed and ready to climb back in the saddle.',
  ];

  static const cyclingDestinations = [
    "On the Road",
    "Oregon is the proud pioneer of scenic bikeways— publicly supported cycling routes that traverse picturesque cultural landmarks.",
    "The Wild Rivers Scenic Bikeway is a 61-mile journey through some of the most appealing scenery in North Curry County. Ride past historic landmarks: Battle Rock, the Elk River fish hatchery, Cape Blanco lighthouse and the Port Orford Coast Guard Museum. The ride starts and ends at Battle Rock Park in Port Orford, just 25 miles south of Bandon. Visit the bikeway’s Travel Oregon page for maps, photos, and more.",
    "On the Trail",
    "Cyclists and hikers get an up-close glimpse of a working Coos County forest at Whiskey Run Mountain Bike Trails. Explore tree stands in various growth stages in a forest that’s home to a wide array of plant species. The trails are open all year with miles of single-track, two-way trails designed for beginner to intermediate difficulty. Find descriptions of each trail, including elevations, at MTB Project.",
    "On the Beach",
    'Ready to hit the sand? Fat tire bike riders are discovering just how fun it is to cruise Bandon beaches on two wheels. Oregon Coast beach rides mapped by Travel Oregon include a 19 mile Bandon fat bike beach ride. The route is easy to split into segments and rated moderately difficult. Highlights include stunning rock formations and splashy stream crossings.',
  ];

  static const cyclingEvents = [
    'Join group walks, hikes and rides offered by Bandon area outdoor recreation and wildlife guides. Area outdoor rec services include guided tours, shuttles, bike rentals and a full service bike shop. Check the event calendar for events, or visit our business guide to book your own guided outing.',
    'The Tour de Fronds is an annual cycling event hosted by the Powers Oregon Lions Club each June. Riders traverse Oregon’s premier Glendale/Powers Bicycle Recreation Area. Routes include options from 30 to 101 miles.',
  ];

  static const beachStaySafe = [
    'Before you hit the sand, review posted signs at beach access points. These public notices will tell you where to find nearby restrooms, provide information about local wildlife, and alert you to potential hazards. Remember to keep an eye on the water. Incoming tides and sneaker waves move quickly. Use caution when climbing on driftwood. Even large logs may be unstable. Watch for numbered signs along Oregon beaches. If you need to call for emergency assistance, noting the nearest numbered marker can help emergency services personnel reach you faster.',
    'Enjoy the wildlife. But look, don’t touch. Be mindful that many of the Bandon area sea stacks and rock formations are wildlife refuges, home to a variety of sea life and shore birds. Harvesting of shellfish and marine vegetation is allowed seasonally. Purchase a shellfish license at one of Bandon’s bait shops or hardware stores, and check seasonal restrictions with the Fish and Wildlife Department.',
    'Overnight camping is prohibited on most public beaches. In general, fires are prohibited at Oregon recreation lands and beaches, except in constructed fire pits at campgrounds. Find the latest fire advisories at the Oregon Parks website, Oregon State Parks.',
  ];

  static const tideTable = [
    'Check Bandon tide levels at the Nation Oceanic and Atmospheric Association website. NOAA provides daily tide tables and predicted levels for upcoming months.',
  ];

  static const beachEvents = [
    'Check the event calendar for interactive beach labyrinth events throughout the year. Watch for Shoreline Education for Awareness interpreters throughout the summer at Coquille Point, in Bandon; and Simpson Reef, just south of Cape Arago in Charleston. Find more information at Shoreline Education Awareness. Take part in spring or fall Oregon SOLVE beach cleanups. Details at SOLVE.',
  ];

  static const yearRound = [
    'SPRING AND SUMMER',
    'The Pacific halibut season kicks off in May and is a local favorite fishery for recreational boaters and charter trips. Ocean bottom fish, salmon and tuna seasons run through the summer months. Bay crabbing and clamming are also popular.',
    'Fresh water fishing in lakes and rivers offers rainbow and cutthroat trout and Chinook salmon.',
    'FALL AND WINTER',
    'Fall is the best time of year to harvest Dungeness crab in the bay at Bandon and in the Empire-Charleston area of Coos Bay.',
    'Area lakes are stocked with rainbow trout at this time, too, and some bass also are available to freshwater lake fishers. Boat and bank fishers take advantage of winter steelhead runs.',
  ];

  static const hatchery = [
    'The Coquille River offers excellent Chinook and coho salmon fishing in the fall and winter and steelhead fishing from December through the end of the run, especially on the North Fork Coquille at Laverne Park and on the South Fork Coquille up to the city of Powers. Wood ducks can be seen year-round at the intake reservoirs. Swallows are common May – September. Herons and kingfishers are common year-round. Picnic tables are available at the hatchery. Visitors can view and feed large rainbow trout in a show pond, and can observe the spawning of salmon and steelhead October – March, usually Tuesday mornings.',
  ];

  static const fishEvents = [
    'Check the summertime event calendar for annual Bandon crab and salmon derbies.',
    'The free, family-friendly summertime lecture series hosted by the Port of Bandon often includes interactive workshops on harvesting shellfish.',
  ];

  static const natureDiscovery = [
    "Bandon Marsh National Wildlife Refuge is a tidal marsh system, providing habitat for salmon and shorebirds, and is an excellent birdwatching destination. The marsh observation deck on Riverside Drive is walking distance from Old Town– just head north on Riverside Drive, at the east end of First Street. The Ni-les’tun unit parking area and observation platform are located on North Bank Road, off Highway 101, just north of Bullards Bridge.",
    "New River is an Area of Critical Environmental Concern located south of Bandon. Learn about the protected habitats at the Nature Center. Then hike the trails or paddle in the estuary. The trailhead and visitor parking are loaded on Croft Lake Lane, off Highway 101.",
  ];

  static const natureInterpretation = [
    "Find Group Events",
    "The local Audubon Society, and Shoreline Education for Awareness, offer indoor and outdoor events throughout the year.",
    "The Cape Arago chapter of the Audubon Society leads programs and outings in Bandon and the surrounding area. Meet fellow birding enthusiasts and learn more about stewardship of natural environments. Join them for their annual Oregon Shorebird Festival held in September.",
    "Shoreline Education for Awareness interpreters share a wealth of knowledge about near shore nesting and bird habitats on the beach and offshore rocks. Find SEA volunteers equipped with spotting scopes, field guides and brochures, Friday through Sunday, May through July, at Coquille Point or Face Rock viewpoints in Bandon.",
    "Additional SEA programs include seminars on King Tides and marine aquaculture. The annual Tufted Puffin Party, at Face Rock State Scenic Viewpoint in April, celebrates the springtime return of puffins to their nesting sites.",
    "Book a Guide",
    "Professional guides share their passion for nature on guided exploration of trails and waterways. Connect with Bandon’s natural wonder! Walks, hikes, kayak and boat tours are available for groups large and small.",
  ];

  static const funForKids = [
    "Watch birds in their natural habitats and learn about the relationship between birds, aquatic life and other species.",
    "Indoors",
    "The Charleston Marine Life Center, located near the Charleston marina, is part of the Oregon Institute of Marine Biology campus. Visitors can learn about natural history in the museum, view aquatic wildlife in the aquarium, and get up close with marine life in the tide pool touch tank. The Marine Life Center is open 11 a.m. to 5 p.m. Wednesday through Saturday. Admission is free for children and students (with student ID), \$5 for adults, and \$4 for seniors.",
    "Outdoors",
    "Pack a picnic and head to the Bandon Fish Hatchery. Birds such as wood ducks, herons and kingfishers are common all year with additional migratory birds visiting in the spring and summer months. View adult Chinook salmon in the fall, steelhead in the winter and spring, and trout in the show pond year round. Take Fish Hatchery Road south off Highway 42 South, approximately one-half mile east of Bandon.",
    "The Junior Ranger program features hands-on nature discovery and learning at Bullards Beach State Park. Sessions begin at 10 a.m., Tuesday through Saturday, mid-June through Labor Day. Youth age 6 to 12 are invited to participate in this free, drop-in program. Children should be accompanied by an adult. Check in at Bullards amphitheater.",
    "Visit the Oregon Coast Birding Trail website and download the South Coast Oregon Birding Trail Guide for more birding adventures.",
  ];

  static const bodyOldTown = [
    "Bandon’s Old Town is 10 square blocks of shopping, dining, history, art, culture and outdoor recreation. Spend an hour, or a day, exploring our historic business district, just off Highway 101 South, on the Coquille River waterfront.",
  ];

  static const shopping = [
    "A stroll through Bandon’s Old Town shopping district is a feast for the senses.",
    "Sample delectable treats, luxurious threads, art and playthings for every age. Our Old Town boutiques and galleries feature distinctive products and service, provided by independent business owners who love what they do and the visitors who brighten the day.",
    "Many of our merchants have been delighting customers for decades: Bandon Card and Gift Shoppe, Bandon Mercantile Company, The Big Wheel General Store, Cranberry Sweets and Second Street Gallery offer that winning combination of quality products and service that bring shoppers back for more.",
  ];

  static const dining = [
    'It’s easy to find a tasty bite in Old Town Bandon.',
    'Looking forward to seafood? Want turf with your surf? Craving a vegetarian repast? Bandon’s got it– from quick bites to multi-course fine dining.',
    'Feel free to ask about seasonal seafood and locally sourced products, including Oregon wines, brews and spirits.',
  ];

  static const artCulture = [
    'On the south bank of the Coquille River, waves lap against the boats in the marina, while gulls swoop and cry overhead. Old Town attractions include public art displays, including one of a kind wood sculptures and the annual Port of Bandon Boardwalk Art Show. Port staff are available to answer questions and get you started fishing and crabbing from your boat, or off Webber’s Pier.',
    'While you stroll, take in the view of the Coquille River lighthouse and watch the seals bobbing in the marina. Our pedestrian-friendly boardwalk features nooks (and benches) where you can pause and enjoy the view. Visit Washed Ashore Art to Save the Sea, in the Harbortown Events Center, for public art installations, workshops and marine education.',
  ];

  static const oldTownEvents = [
    'Old Town is a hub of activity during the 4th of July, the annual September Cranberry Festival, and the winter holidays.',
    'Watch the event calendar for the free, family-friendly summertime lecture series at the Port of Bandon boardwalk picnic shelter. Enjoy interactive presentations on wildlife, local history and more.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandon Things To Do'),
      ),
      endDrawer: const SettingsDrawer(),
      body: Container(
        decoration: gradientBackground(context),
        child: ListView(
          children: <Widget>[
            StyledTopBanner(topText: 'Things To Do'),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Image.asset(
                  'assets/images/things-to-do/bandon-things-to-do.jpg'),
            ),
            const PaddedTextBody(textBody: body1),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Image.asset('assets/images/separator.png'),
            ),
            StyledTopBanner(
              topText: 'Golf on the',
              bottomText: 'Southern Oregon Coast',
              fontSize: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child:
                  Image.asset('assets/images/things-to-do/bandon-golfing.jpg'),
            ),
            const StyledExpansionTile(
              title: 'Links Style Golf',
              hiddenContent: linksStyleGolf,
            ),
            const StyledExpansionTile(
              title: 'Award-Winning Public Courses',
              hiddenContent: publicCourses,
            ),
            const StyledExpansionTile(
              title: 'Events',
              hiddenContent: golfEvents,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Image.asset('assets/images/separator-golf.png'),
            ),
            const StyledSectionBanner(
              leftText: 'Cycle and Hike',
              rightText: 'in Bandon',
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child:
                  Image.asset('assets/images/things-to-do/bandon-hiking.jpg'),
            ),
            const StyledExpansionTile(
              title: 'Go Wild on the Southern Oregon Coast',
              hiddenContent: goWild,
            ),
            const StyledExpansionTile(
              title: 'Cyclist Layover',
              hiddenContent: cyclistLayover,
            ),
            const StyledExpansionTile(
              title: 'Cycling Destinations',
              hiddenContent: cyclingDestinations,
            ),
            const StyledExpansionTile(
              title: 'Events & Guided Tours',
              hiddenContent: cyclingEvents,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Image.asset('assets/images/separator-bicycle.png'),
            ),
            const StyledSectionBanner(
              leftText: 'Beach-Going',
              rightText: 'in Bandon',
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child:
                  Image.asset('assets/images/things-to-do/bandon-beaches.jpg'),
            ),
            const PaddedTextBody(
              textBody: bodyBeach,
            ),
            const StyledExpansionTile(
              title: 'Stay Safe and Respect the Environment',
              hiddenContent: beachStaySafe,
            ),
            const StyledExpansionTile(
              title: 'Tide Table',
              hiddenContent: tideTable,
            ),
            const StyledExpansionTile(
              title: 'Events',
              hiddenContent: beachEvents,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Image.asset('assets/images/separator-beaches.png'),
            ),
            StyledSectionBanner(
              leftText: "Fishing",
              rightText: "Bandon",
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child:
                  Image.asset('assets/images/things-to-do/bandon-fishing.jpg'),
            ),
            const PaddedTextBody(
              textBody: bodyFishing,
            ),
            const StyledExpansionTile(
              title: 'Year-Round Angling',
              hiddenContent: yearRound,
            ),
            const StyledExpansionTile(
              title: 'Bandon Hatchery',
              hiddenContent: hatchery,
            ),
            const StyledExpansionTile(
              title: 'Tide Table',
              hiddenContent: tideTable,
            ),
            const StyledExpansionTile(
              title: 'Events',
              hiddenContent: fishEvents,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Image.asset('assets/images/separator-beaches.png'),
            ),
            const StyledSectionBanner(
              leftText: 'Birding',
              rightText: 'in Bandon',
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child:
                  Image.asset('assets/images/things-to-do/bandon-birding.jpg'),
            ),
            const PaddedTextBody(
              textBody: bodyBirding,
            ),
            const StyledExpansionTile(
              title: 'Birdwatching & Nature Discovery',
              hiddenContent: natureDiscovery,
            ),
            const StyledExpansionTile(
              title: 'Nature Interpretation & Events',
              hiddenContent: natureInterpretation,
            ),
            const StyledExpansionTile(
              title: 'Fun for Families & Youngsters',
              hiddenContent: funForKids,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Image.asset('assets/images/separator-bird.png'),
            ),
            const StyledSectionBanner(
              leftText: 'Historic',
              rightText: 'Old Town',
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child:
                  Image.asset('assets/images/things-to-do/bandon-oldtown.jpg'),
            ),
            const PaddedTextBody(
              textBody: bodyOldTown,
            ),
            const StyledExpansionTile(
              title: 'Shopping',
              hiddenContent: shopping,
            ),
            const StyledExpansionTile(
              title: 'Dining',
              hiddenContent: dining,
            ),
            const StyledExpansionTile(
              title: 'Art, Culture and Outdoor Recreation',
              hiddenContent: artCulture,
            ),
            const StyledExpansionTile(
              title: 'Events',
              hiddenContent: oldTownEvents,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Image.asset('assets/images/separator.png'),
            ),
          ],
        ),
      ),
    );
  }
}
