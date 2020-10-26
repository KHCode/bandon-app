import 'package:sqflite/sqflite.dart';

import 'event_dto.dart';
import '../models/event.dart';

class DatabaseManager {
  static const String DATABASE_FILENAME = 'events.sqlite3.db';
  static const String SQL_DROP_TABLE = 'DROP TABLE IF EXISTS events;';
  static const String SQL_INSERT =
      'INSERT INTO events(title, description, permalink, startDate, endDate, dateDetails, location, admission, website, contact, email) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);';
  static const String SQL_SELECT = 'SELECT * FROM events;';

  static DatabaseManager _instance;

  final Database db;

  DatabaseManager._({Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize(String schema) async {
    final db = await openDatabase(DATABASE_FILENAME, version: 1,
        onCreate: (Database db, int version) async {
      _createTables(db, schema);
    });
    _instance = DatabaseManager._(database: db);
  }

  static void _createTables(Database db, String sql) async {
    await db.execute(SQL_DROP_TABLE);
    await db.execute(sql);
  }

  void saveEvent({EventDTO dto}) {
    db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT, [
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

  Future<List<Event>> getEvents() async {
    final eventRecords = await db.rawQuery(SQL_SELECT);
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
      );
    }).toList();
    return events;
  }
}
