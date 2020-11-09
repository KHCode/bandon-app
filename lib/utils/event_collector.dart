import 'package:web_scraper/web_scraper.dart';

import '../db/database_manager.dart';
import '../db/event_dto.dart';

class EventCollector {
  final String url;

  const EventCollector({this.url});

  Future<bool> getEvents() async {
    final databaseManager = DatabaseManager.getInstance();
    final _events = await _getEventUrls();

    for (var eventUrl in _events) {
      final _event = await _getEventDetails(eventUrl);
      databaseManager.saveEvent(dto: _event);
    }

    return _events.isNotEmpty ? true : false;
  }

  Future<List<String>> _getEventUrls() async {
    final _eventList = <String>[];
    final _webScraper = WebScraper('https://tourism.bandon.com');
    final _endpoint = url.replaceAll(r'https://tourism.bandon.com', '');
    if (await _webScraper.loadWebPage(_endpoint)) {
      final _eventUrls = _webScraper.getElement(
          'div#gz-events > div.gz-list-card-wrapper > div.gz-events-card > div.card-header > a',
          ['href']);
      for (var urlElement in _eventUrls) {
        final String _eventUrl = urlElement['attributes']['href'];
        _eventList.add('$_eventUrl');
      }
    } else {
      print('Failed to load the event list');
    }
    return _eventList;
  }

  Future<EventDTO> _getEventDetails(String eventUrl) async {
    final _newEvent = EventDTO();

    final _webScraper = WebScraper('https://tourism.bandon.com');
    final _endpoint = eventUrl.replaceAll(r'https://tourism.bandon.com', '');
    if (await _webScraper.loadWebPage(_endpoint)) {
      final Map<String, dynamic> _dateDetails = _getEventDate(_webScraper);
      final _dateDetails = _getEventDate(_webScraper);
      _newEvent.startDate = _dateDetails['startDate'];
      _newEvent.endDate = _dateDetails['endDate'];
      _newEvent.dateDetails = _dateDetails['dateDetails'];
      _newEvent.permalink = eventUrl;
      _newEvent.title = _getEventTitle(_webScraper);
      _newEvent.description = _getEventDescription(_webScraper);
      _newEvent.location = _getEventLocation(_webScraper);
      _newEvent.admission = _getEventAdmission(_webScraper);
      _newEvent.website = _getEventWebsite(_webScraper);
      _newEvent.contact = _getEventContact(_webScraper);
      _newEvent.email = _getEventEmail(_webScraper);
    } else {
      print('Failed to load the event');
    }

    return _newEvent;
  }

  String _getEventTitle(WebScraper webScraper) {
    String _title;

    final _elements = webScraper.getElement('h1.gz-pagetitle', []);
    _elements.isNotEmpty ? _title = _elements.first['title'] : _title = '';

    return _title;
  }

  String _getEventDescription(WebScraper webScraper) {
    String _description;

    final _elements =
        webScraper.getElement('div.gz-event-description > div > p', []);
    _elements.isNotEmpty
        ? _description = _elements.first['title']
        : _description = '';

    return _description;
  }
}

Map<String, dynamic> _getEventDate(WebScraper webScraper) {
  final _date = <String, dynamic>{};
  DateTime _startDate;
  DateTime _endDate;
  String _dateDetails;

  final _startDateElements = webScraper
      .getElement('div.gz-event-date > p > span:first-child', ['content']);
  _startDateElements.isNotEmpty
      ? _startDate =
          DateTime.parse(_startDateElements.first['attributes']['content'])
      : _startDate = null;

  final _endDateElements =
      webScraper.getElement('div.gz-event-date > p > meta', ['content']);
  _endDateElements.isNotEmpty
      ? _endDate =
          DateTime.parse(_endDateElements.first['attributes']['content'])
      : _endDate = null;

  final _dateDetailsElements =
      webScraper.getElement('div.gz-event-date > div.gz-details-hours > p', []);
  _dateDetailsElements.isNotEmpty
      ? _dateDetails = _dateDetailsElements.first['title']
      : _dateDetails = '';

  _date['startDate'] = _startDate ?? DateTime.parse('00010101');
  _date['endDate'] = _endDate ?? DateTime.parse('00010101');
  _date['dateDetails'] = _dateDetails;

  return _date;
}

String _getEventLocation(WebScraper webScraper) {
  String _location;

  final _elements =
      webScraper.getElement('div.gz-event-location > p > span', []);
  _elements.isNotEmpty ? _location = _elements.first['title'] : _location = '';

  return _location;
}

String _getEventAdmission(WebScraper webScraper) {
  String _admission;

  final _elements = webScraper.getElement('span.gz-event-fees', []);
  _elements.isNotEmpty
      ? _admission = _elements.first['title']
      : _admission = '';

  return _admission;
}

String _getEventWebsite(WebScraper webScraper) {
  String _website;

  final _elements =
      webScraper.getElement('div.gz-event-website > p > span > a', ['href']);
  _elements.isNotEmpty
      ? _website = _elements.first['attributes']['href']
      : _website = '';

  return _website;
}

String _getEventContact(WebScraper webScraper) {
  String _contact;

  final _elements = webScraper
      .getElement('div.gz-event-contactInfo > p > span:first-child', []);
  _elements.isNotEmpty ? _contact = _elements.first['title'] : _contact = '';

  return _contact;
}

String _getEventEmail(WebScraper webScraper) {
  String _email;

  final _elements = webScraper
      .getElement('div.gz-event-contactInfo > p > span > a', ['href']);
  _elements.isNotEmpty
      ? _email = _elements.first['attributes']['href']
      : _email = '';

  if (!_email.contains('@')) {
    _email = '';
  }

  return _email;
}
