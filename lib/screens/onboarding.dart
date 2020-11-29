import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import '../widgets/aligned_image.dart';

class OnboardingPage extends StatefulWidget {
  final String title;
  final String prefsKey;
  final SharedPreferences prefs;

  const OnboardingPage(
      {Key key,
      @required this.title,
      @required this.prefs,
      @required this.prefsKey})
      : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onDone(BuildContext context) {
    widget.prefs.setBool(widget.prefsKey, true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomePage(title: 'Bandon')),
    );
  }

  void _requestPermissions(BuildContext context) async {
    LocationPermission _permission;

    try {
      _permission = await Geolocator.requestPermission();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
    } on PermissionRequestInProgressException catch (e) {
      print('Error: ${e.toString()}');
    }

    print('Location Permissions: ' + _permission.toString());
    _onDone(context);
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 22.0),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: 'See the sights',
          body: 'Learn about all of the activities Bandon has to offer.',
          image: const AlignedImage(
              fileName: 'lighthouse.png',
              size: 350.0,
              alignment: Alignment.bottomCenter),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Get to know us',
          body: 'Find shops, dining, lodging and events around town.',
          image: const AlignedImage(
              fileName: 'dining.png',
              size: 350.0,
              alignment: Alignment.bottomCenter),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Enable location access',
          body:
              "It's like having your own concierge.\n\nTap the button below to find how close you are to the greatest Bandon has to offer.",
          image: const AlignedImage(
              fileName: 'map.png',
              size: 350.0,
              alignment: Alignment.bottomCenter),
          footer: RaisedButton(
            onPressed: () {
              _requestPermissions(context);
            },
            child: const Text(
              'Enable Location',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onDone(context),
      showSkipButton: false,
      nextFlex: 0,
      next: const Icon(Icons.navigate_next),
      done: const Text('Skip'),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeSize: Size(20.0, 20.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
