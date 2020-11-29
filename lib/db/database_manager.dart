import 'package:sqflite/sqflite.dart';

import 'business_dto.dart';
import 'event_dto.dart';
import '../models/business.dart';
import '../models/event.dart';

class DatabaseManager {
  static const DATABASE_FILENAME = 'events.sqlite3.db';
  static const SQL_DROP_EVENTS_TABLE = 'DROP TABLE IF EXISTS events;';
  static const SQL_DROP_BUSINESSES_TABLE = 'DROP TABLE IF EXISTS businesses;';
  static const SQL_INSERT_EVENT = '''INSERT OR REPLACE INTO events(
        title, description, permalink, startDate, endDate, dateDetails, location, admission, website, contact, email, isFavorite, dateFavorited)
        VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, (SELECT isFavorite FROM events WHERE permalink = ?3), (SELECT dateFavorited FROM events WHERE permalink = ?3));''';
  static const SQL_INSERT_BUSINESS = '''INSERT OR REPLACE INTO businesses(
        name, aboutUs, permalink, categories, address, phone, website, hours, highlights, isFavorite, dateFavorited)
        VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, (SELECT isFavorite FROM events WHERE permalink = ?3), (SELECT dateFavorited FROM events WHERE permalink = ?3));''';
  static const SQL_SELECT_EVENTS =
      'SELECT * FROM events ORDER BY datetime(startDate);';
  static const SQL_SELECT_BUSINESSES =
      'SELECT * FROM businesses ORDER BY name ASC;';
  static const SQL_SELECT_ONE_EVENT =
      'SELECT * FROM events WHERE permalink = ?;';
  static const SQL_SELECT_ONE_BUSINESS =
      'SELECT * FROM businesses WHERE permalink = ?;';
  static const SQL_SELECT_FAVORITE_EVENTS =
      'SELECT * FROM events WHERE isFavorite = 1 ORDER BY datetime(startDate);';
  static const SQL_SELECT_FAVORITE_BUSINESSES =
      'SELECT * FROM businesses WHERE isFavorite = 1 ORDER BY name ASC;';
  static const SQL_UPDATE_FAVORITE_EVENT =
      'UPDATE events SET isFavorite = ?, dateFavorited = ? WHERE permalink = ?;';
  static const SQL_UPDATE_FAVORITE_BUSINESS =
      'UPDATE businesses SET isFavorite = ?, dateFavorited = ? WHERE permalink = ?;';
  static const SQL_DELETE_OLD_EVENTS =
      'DELETE FROM events WHERE datetime(endDate) > datetime(?) AND datetime(endDate) < ?;';
  static const SQL_SELECT_OLD_EVENTS =
      'SELECT * FROM events WHERE datetime(endDate) > datetime(?) AND datetime(endDate) < ?;';

  static DatabaseManager _instance;

  final Database db;

  DatabaseManager._({Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize(String schema) async {
    final db = await openDatabase(
      DATABASE_FILENAME,
      version: 3,
      onCreate: (Database db, int version) {
        _createTables(db, schema);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {
        _createTables(db, schema);
      },
    );
    _instance = DatabaseManager._(database: db);
  }

  static void _createTables(Database db, String sql) async {
    await db.execute(SQL_DROP_EVENTS_TABLE);
    await db.execute(SQL_DROP_BUSINESSES_TABLE);
    for (final statement in sql.split(';')) {
      if (statement.trim().isNotEmpty) {
        await db.execute('${statement.trim()};');
      }
    }
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

  void setFavoriteEvent({String permalink, bool isFavorite}) {
    final favorite = isFavorite ? 1 : 0;
    final date = isFavorite ? DateTime.now().toUtc().toString() : null;
    db.transaction((txn) async {
      await txn
          .rawUpdate(SQL_UPDATE_FAVORITE_EVENT, [favorite, date, permalink]);
    });
  }

  Future<void> _cleanStaleEvents() async {
    // Remove events that with an end date that's prior to the current time that
    // also had an end date that the event collection parsed successfully
    // (i.e., a date that's greater than 1/1/1).
    await db.transaction((txn) async {
      await txn.rawDelete(SQL_DELETE_OLD_EVENTS,
          [DateTime.parse('00010101').toString(), DateTime.now().toString()]);
    });
  }

  Future<List<Event>> getEvents() async {
    await _cleanStaleEvents();
    final _eventRecords = await db.rawQuery(SQL_SELECT_EVENTS);
    final _events = _eventRecords
        .map(
          (record) => Event(
            title: record['title'].toString(),
            description: record['description'].toString(),
            permalink: record['permalink'].toString(),
            startDate: DateTime.parse(record['startDate'].toString()),
            endDate: DateTime.parse(record['endDate'].toString()),
            dateDetails: record['dateDetails'].toString(),
            location: record['location'].toString(),
            admission: record['admission'].toString(),
            website: record['website'].toString(),
            contact: record['contact'].toString(),
            email: record['email'].toString(),
            isFavorite: record['isFavorite'] == 1 ? true : false,
            dateFavorited:
                DateTime.parse(record['dateFavorited'] ?? '00010101'),
          ),
        )
        .toList();
    return _events;
  }

  Future<List<Event>> getFavoriteEvents() async {
    final _eventRecords = await db.rawQuery(SQL_SELECT_FAVORITE_EVENTS);
    final _events = _eventRecords
        .map(
          (record) => Event(
              title: record['title'].toString(),
              description: record['description'].toString(),
              permalink: record['permalink'].toString(),
              startDate: DateTime.parse(record['startDate'].toString()),
              endDate: DateTime.parse(record['endDate'].toString()),
              dateDetails: record['dateDetails'].toString(),
              location: record['location'].toString(),
              admission: record['admission'].toString(),
              website: record['website'].toString(),
              contact: record['contact'].toString(),
              email: record['email'].toString(),
              isFavorite: true,
              dateFavorited: record['dateFavorited']),
        )
        .toList();
    return _events;
  }

  void setFavoriteBusiness({String permalink, bool isFavorite}) {
    final favorite = isFavorite ? 1 : 0;
    final date = isFavorite ? DateTime.now().toUtc().toString() : null;
    db.transaction((txn) async {
      await txn
          .rawUpdate(SQL_UPDATE_FAVORITE_BUSINESS, [favorite, date, permalink]);
    });
  }

  void saveBusiness({BusinessDTO dto}) {
    db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT_BUSINESS, [
        dto.name,
        dto.aboutUs,
        dto.permalink,
        dto.categories,
        dto.address,
        dto.phone,
        dto.website,
        dto.hours,
        dto.highlights,
      ]);
    });
  }

  Future<List<Business>> getBusinesses() async {
    final _businessRecords = await db.rawQuery(SQL_SELECT_BUSINESSES);
    final _businesses = _businessRecords
        .map(
          (record) => Business(
            name: record['name'].toString(),
            aboutUs: record['aboutUs'].toString(),
            permalink: record['permalink'].toString(),
            categories: record['categories'].toString(),
            address: record['address'].toString(),
            phone: record['phone'].toString(),
            website: record['website'].toString(),
            hours: record['hours'].toString(),
            highlights: record['highlights'].toString(),
            isFavorite: record['isFavorite'] == 1 ? true : false,
            dateFavorited:
                DateTime.parse(record['dateFavorited'] ?? '00010101'),
          ),
        )
        .toList();
    return _businesses;
  }
}
