import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/database_manager.dart';
import '../models/event.dart';

class EventsScreen extends StatefulWidget {
  static const routeName = 'eventsScreen';

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  Future<List<Event>> _getEvents() async {
    final databaseManager = DatabaseManager.getInstance();
    return await databaseManager.getEvents();
  }

  Widget _createEventsListView(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData && snapshot.data.length > 0) {
      return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(
                  leading: InkWell(
                    child: Icon(snapshot.data[index].isFavorite
                        ? Icons.favorite
                        : Icons.favorite_outline),
                    onTap: () => {_toggleFavorite(snapshot.data[index])},
                  ),
                  title: Text(snapshot.data[index].title),
                  subtitle: Text(DateFormat("EEEE',' MMM'.' d")
                      .format(snapshot.data[index].startDate)),
                  trailing: Icon(Icons.navigate_next)),
            ],
          );
        },
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  void _toggleFavorite(Event event) {
    print("Toggled!");
    final databaseManager = DatabaseManager.getInstance();
    databaseManager.setFavorite(
        permalink: event.permalink, isFavorite: !event.isFavorite);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: FutureBuilder(
        future: _getEvents(),
        initialData: [],
        builder: (context, snapshot) {
          return _createEventsListView(context, snapshot);
        },
      ),
    );
  }
}
