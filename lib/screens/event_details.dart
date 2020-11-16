import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';

class EventDetails extends StatefulWidget {
  static const routeName = 'eventDetails';

  EventDetails({Key key}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Event _event;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments is Event) {
      _event = ModalRoute.of(context).settings.arguments;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding(context)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  _event.title,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  parseDate(_event.startDate),
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Text(
                  _event.description,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
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

String parseDate(DateTime dateTime) {
  return '${DateFormat("EEEE',' MMM'.' d',' y").format(dateTime)}';
}
