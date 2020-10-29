import 'package:sqflite/sqflite.dart';

import 'event_dto.dart';
import '../models/event.dart';

class DatabaseManager {
  static const String DATABASE_FILENAME = 'events.sqlite3.db';
  static const String SQL_DROP_EVENTS_TABLE = 'DROP TABLE IF EXISTS events;';
  static const String SQL_INSERT_EVENT = '''INSERT OR REPLACE INTO events(
        title, description, permalink, startDate, endDate, dateDetails, location, admission, website, contact, email, isFavorite, dateFavorited)
        VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, (SELECT isFavorite FROM events WHERE permalink = ?3), (SELECT dateFavorited FROM events WHERE permalink = ?3));''';
  static const String SQL_SELECT_EVENTS =
      'SELECT * FROM events ORDER BY date(startDate);';
  static const String SQL_SELECT_FAVORITE_EVENTS =
      'SELECT * FROM events WHERE isFavorite = 1 ORDER BY date(startDate);';
  static const String SQL_UPDATE_FAVORITE_EVENT =
      'UPDATE events SET isFavorite = ?, dateFavorited = ? WHERE permalink = ?;';

  static DatabaseManager _instance;

  final Database db;

  DatabaseManager._({Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize(String schema) async {
    final db = await openDatabase(DATABASE_FILENAME, version: 1,
        onCreate: (Database db, int version) {
      _createTables(db, schema);
    }, onOpen: (Database db) {
      _createTables(db, schema);
    });
    _instance = DatabaseManager._(database: db);
  }

  static void _createTables(Database db, String sql) async {
    // await db.execute(SQL_DROP_EVENTS_TABLE);
    await db.execute(sql);
  }

  void saveEvent({EventDTO dto}) {
    db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT_EVENT, [
        dto.title,
        dto.description,
        dto.permalink,
        dto.startDate.toString(),
        dto.endDate.toString(),
        dto.dateDetails,
        dto.location,
        dto.admission,
        dto.website,
        dto.contact,
        dto.email,
      ]);
    });
  }

  void setFavorite({String permalink, bool isFavorite}) {
    final favorite = isFavorite ? 1 : 0;
    final date = isFavorite ? DateTime.now().toString() : null;
    db.transaction((txn) async {
      await txn
          .rawUpdate(SQL_UPDATE_FAVORITE_EVENT, [favorite, date, permalink]);
    });
  }

  Future<List<Event>> getEvents() async {
    final eventRecords = await db.rawQuery(SQL_SELECT_EVENTS);
    final events = eventRecords.map((record) {
      print(
          '${record['id']}: ${record['isFavorite']} - ${record['dateFavorited'] ?? 'Not favorited'}');
      return Event(
        title: record['title'],
        description: record['description'],
        permalink: record['permalink'],
        startDate: DateTime.parse(record['startDate']),
        endDate: DateTime.parse(record['endDate']),
        dateDetails: record['dateDetails'],
        location: record['location'],
        admission: record['admission'],
        website: record['website'],
        contact: record['contact'],
        email: record['email'],
        isFavorite: record['isFavorite'] == 1 ? true : false,
        dateFavorited: DateTime.parse(record['dateFavorited'] ?? '00010101'),
      );
    }).toList();
    return events;
  }

  Future<List<Event>> getFavoriteEvents() async {
    final eventRecords = await db.rawQuery(SQL_SELECT_FAVORITE_EVENTS);
    final events = eventRecords.map((record) {
      return Event(
          title: record['title'],
          description: record['description'],
          permalink: record['permalink'],
          startDate: DateTime.parse(record['startDate']),
          endDate: DateTime.parse(record['endDate']),
          dateDetails: record['dateDetails'],
          location: record['location'],
          admission: record['admission'],
          website: record['website'],
          contact: record['contact'],
          email: record['email'],
          isFavorite: true,
          dateFavorited: record['dateFavorited']);
    }).toList();
    return events;
  }
}
