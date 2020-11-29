import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'find_business.dart';
import '../models/business.dart';
import '../widgets/settings_drawer.dart';

class BusinessDetails extends StatefulWidget {
  static const routeName = 'businessDetails';

  BusinessDetails({Key key}) : super(key: key);

  @override
  _BusinessDetailsState createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  Business _business;

  void pushBusinessCategory(BuildContext context, String category) =>
      Navigator.of(context)
          .pushNamed(FindBusinessScreen.routeName, arguments: category);

  void _launchMap(address) async {
    String url;

    if (Platform.isIOS) {
      url = Uri.parse('http://maps.apple.com/?q=$address').toString();
    } else {
      url =
          Uri.parse('https://www.google.com/maps/search/?api=1&query=$address')
              .toString();
    }

    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _launchPhone(String phoneNumber) async {
    var _phone = phoneNumber.replaceAll(RegExp(r'\W'), '');
    if (await canLaunch('tel:${_phone}')) {
      await launch(phoneNumber);
    }
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget displayName(BuildContext context, Business business) {
    if (business?.website?.isEmpty ?? true) {
      return Text(
        business.name,
        style: Theme.of(context).textTheme.headline4,
        textAlign: TextAlign.center,
      );
    } else {
      return InkWell(
        onTap: () => _launchUrl(business.website),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.headline4,
            children: <InlineSpan>[
              TextSpan(text: business.name),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child:
                      Icon(Icons.launch, color: Theme.of(context).accentColor),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget displayCategories(BuildContext context, Business business) {
    final categoryLinks = <Widget>[];

    for (final category in business.categories.split(';')) {
      categoryLinks.add(
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              category,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Theme.of(context).accentColor),
            ),
          ),
          onTap: () => pushBusinessCategory(context, category),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: categoryLinks,
    );
  }

  Widget displayAddress(BuildContext context, Business business) {
    return Column(
      children: [
        InkWell(
          onTap: () => _launchMap(business.address),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headline6,
              children: <InlineSpan>[
                TextSpan(
                  text: business.address,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Theme.of(context).accentColor),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child:
                        Icon(Icons.map, color: Theme.of(context).accentColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        FutureBuilder(
          initialData: '',
          future: displayDistanceMessage(business.address),
          builder: (context, snapshot) {
            return (snapshot.hasData && snapshot.data.isNotEmpty)
                ? Text(snapshot.data)
                : const SizedBox.shrink();
          },
        ),
        const SizedBox(
          height: 20.0,
        )
      ],
    );
  }

  Widget displayHours(BuildContext context, Business business) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hours',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contact us to confirm before arriving',
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 24.0),
              child: Text(
                business.hours,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget displayAboutUs(BuildContext context, Business business) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'About Us',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 24.0),
              child: Text(
                business.aboutUs,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget displayHighlights(BuildContext context, Business business) {
    var highlights = '';
    for (final highlight in business.highlights.split(';')) {
      highlights += '\u2022 $highlight\n';
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Highlights',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 24.0),
              child: Text(
                highlights,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<String> displayDistanceMessage(String address) async {
    final _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied ||
        _permission == LocationPermission.deniedForever) {
      return '';
    } else {
      final distance = await calcDistanceInMiles(address);
      return '$distance miles away';
    }
  }

  Future<String> calcDistanceInMiles(String address) async {
    final distanceMeters = await getMetersFromAddress(address);
    return (distanceMeters / 1609.344).toStringAsFixed(1);
  }

  Future<double> getMetersFromAddress(String address) async {
    Position _position;
    try {
      _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } on PermissionRequestInProgressException catch (e) {
      print('Error: ${e.toString()}');
    }

    final _locations =
        await locationFromAddress(address, localeIdentifier: 'en_US');

    return Geolocator.distanceBetween(_position.latitude, _position.longitude,
        _locations[0].latitude, _locations[0].longitude);
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments is Business) {
      _business = ModalRoute.of(context).settings.arguments;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Details'),
        actions: <Widget>[
          if (_business?.phone?.isNotEmpty ?? false)
            IconButton(
              onPressed: () => _launchPhone(_business.phone),
              icon: Icon(Icons.phone),
            ),
          IconButton(
            onPressed: () =>
                Share.share('Check this out: ${_business.permalink}'),
            icon: Icon(Icons.share),
          ),
        ],
      ),
      endDrawer: const SettingsDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              displayName(context, _business),
              const SizedBox(height: 10.0),
              if (_business?.categories?.isNotEmpty ?? false)
                displayCategories(context, _business),
              const SizedBox(height: 10.0),
              if (_business?.address?.isNotEmpty ?? false)
                displayAddress(context, _business),
              if (_business?.hours?.isNotEmpty ?? false)
                displayHours(context, _business),
              if (_business?.aboutUs?.isNotEmpty ?? false)
                displayAboutUs(context, _business),
              if (_business?.highlights?.isNotEmpty ?? false)
                displayHighlights(context, _business),
            ],
          ),
        ),
      ),
    );
  }
}

double padding(BuildContext context) {
  return (MediaQuery.of(context).orientation == Orientation.landscape)
      ? MediaQuery.of(context).size.width * 0.05
      : MediaQuery.of(context).size.width * 0.1;
}
