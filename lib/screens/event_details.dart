import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/event.dart';
import '../widgets/settings_drawer.dart';

class EventDetails extends StatefulWidget {
  static const routeName = 'eventDetails';

  EventDetails({Key key}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Event _event;

  void _launchMap(address) async {
    var url =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$address')
            .toString();
    if (Platform.isIOS) {
      url = Uri.parse('http://maps.apple.com/?q=$address').toString();
    }
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget displayTitle(BuildContext context, Event event) {
    if (event?.website?.isEmpty ?? true) {
      return Text(
        event.title,
        style: Theme.of(context).textTheme.headline4,
        textAlign: TextAlign.center,
      );
    } else {
      return InkWell(
        onTap: () => _launchUrl(event.website),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.headline4,
            children: <InlineSpan>[
              TextSpan(text: event.title),
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

  Widget displayTime(BuildContext context, Event event) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contact us to confirm',
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
              child: Text(
                '${parseDate(event.startDate)} ${parseTime(event.startDate)} - \n'
                '${parseDate(event.endDate)} ${parseTime(event.endDate)}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            if (event?.dateDetails?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
                child: Text(_event.dateDetails),
              ),
          ],
        ),
      ],
    );
  }

  Widget displayDescription(BuildContext context, Event event) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Details',
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
                event.description,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget displayLocation(BuildContext context, Event event) {
    if (!event.location.contains(RegExp(r'(OR)|(Oregon)|(97\d{3})'))) {
      return Text(
        event.location,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      );
    } else {
      return Column(
        children: [
          InkWell(
            onTap: () => _launchMap(event.location),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.headline6,
                children: <InlineSpan>[
                  TextSpan(
                    text: event.location,
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
            future: displayDistanceMessage(event.location),
            builder: (context, snapshot) {
              return (snapshot.hasData && snapshot.data.isNotEmpty)
                  ? Text(snapshot.data)
                  : const SizedBox.shrink();
            },
          ),
          SizedBox(
            height: 12.0,
          )
        ],
      );
    }
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
    if (ModalRoute.of(context).settings.arguments is Event) {
      _event = ModalRoute.of(context).settings.arguments;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        actions: <Widget>[
          IconButton(
            onPressed: () => Share.share('Check this out: ${_event.permalink}'),
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
                displayTitle(context, _event),
                SizedBox(height: 10),
                if (_event.startDate != DateTime.parse('00010101') &&
                    _event.endDate != DateTime.parse('00010101'))
                  displayTime(context, _event),
                if (_event?.location?.isNotEmpty ?? false)
                  displayLocation(context, _event),
                if (_event?.description?.isNotEmpty ?? false)
                  displayDescription(context, _event),
              ]),
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

String parseDate(DateTime dateTime) =>
    '${DateFormat("EEEE',' MMM'.' d',' y").format(dateTime)}';

String parseTime(DateTime dateTime) => '${DateFormat("jm").format(dateTime)}';
