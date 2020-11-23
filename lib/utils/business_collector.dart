import 'package:http/http.dart' as http;
import 'package:web_scraper/web_scraper.dart';

import '../db/database_manager.dart';
import '../db/business_dto.dart';

class BusinessCollector {
  final String url;

  const BusinessCollector({this.url});

  Future<bool> getBusinesses() async {
    final databaseManager = DatabaseManager.getInstance();
    final _businesses = await _getBusinessUrls();

    for (final businessUrl in _businesses) {
      final _business = await _getBusinessDetails(businessUrl);
      if (_business.isNull) {
        print("Couldn't retrieve the business at $businessUrl");
      } else {
        databaseManager.saveBusiness(dto: _business);
      }
    }
    return _businesses.isNotEmpty ? true : false;
  }

  Future<List<String>> _getBusinessUrls() async {
    const MAX_FAILURES = 10;
    var _businessId = 1;
    var _consecutiveFailures = 10;

    final _urls = <String>[];
    final _client = http.Client();

    try {
      do {
        final _req = http.Request('HEAD', Uri.parse('$url/member/$_businessId'))
          ..followRedirects = false;
        final _res = await _client.send(_req);

        if (_res.statusCode == 301) {
          final _endpoint = _res.headers['location'];
          final _verificationReq = http.Request('HEAD', Uri.parse(_endpoint))
            ..followRedirects = false;
          final _verificationRes = await _client.send(_verificationReq);

          if (_verificationRes.statusCode == 200) {
            _urls.add(_endpoint);

            // Reset the consecutive failure count if successful and there were
            // failures prior to this successful fetch
            if (_consecutiveFailures != 0) {
              _consecutiveFailures = 0;
            }
          } else {
            _consecutiveFailures++;
          }
        } else {
          _consecutiveFailures++;
        }
        _businessId++;
      } while (_consecutiveFailures < MAX_FAILURES);
    } finally {
      _client.close();
    }

    return _urls;
  }

  Future<BusinessDTO> _getBusinessDetails(String businessUrl) async {
    final _newBusiness = BusinessDTO();

    final _webScraper = WebScraper('https://tourism.bandon.com');
    final _endpoint = businessUrl.replaceAll(r'https://tourism.bandon.com', '');
    if (await _webScraper.loadWebPage(_endpoint)) {
      _newBusiness.name = _getName(_webScraper).trim();
      if (_newBusiness?.name?.isEmpty ?? true) {
        return _newBusiness;
      }
      _newBusiness.permalink = businessUrl;
      _newBusiness.categories = _getCategories(_webScraper).trim();
      _newBusiness.aboutUs = _getAboutUs(_webScraper).trim();
      _newBusiness.address = _getAddress(_webScraper).trim();
      _newBusiness.phone = _getPhone(_webScraper).trim();
      _newBusiness.website = _getWebsite(_webScraper).trim();
      _newBusiness.hours = _getHours(_webScraper).trim();
      _newBusiness.highlights = _getHighlights(_webScraper).trim();
    } else {
      print('Failed to load the business');
    }

    return _newBusiness;
  }

  String _getName(WebScraper webScraper) {
    String _name;

    final _elements = webScraper.getElement('h1.gz-pagetitle', []);
    _elements.isNotEmpty ? _name = _elements.first['title'] : _name = '';

    return _name;
  }

  String _getCategories(WebScraper webScraper) {
    final _categories = <String>[];

    final _elements = webScraper.getElement('span.gz-cat', []);
    for (final element in _elements) {
      _categories.add(element['title']);
    }

    return _categories.join(';');
  }

  String _getAboutUs(WebScraper webScraper) {
    String _aboutUs;

    final _elements =
        webScraper.getElement('div.gz-details-about > div > p', []);
    _elements.isNotEmpty ? _aboutUs = _elements.first['title'] : _aboutUs = '';

    return _aboutUs;
  }
}

String _getAddress(WebScraper webScraper) {
  final _address = <String>[];

  final _streetAddress = webScraper.getElement('span.gz-street-address', []);
  final _city = webScraper.getElement('span.gz-address-city', []);
  final _state = webScraper.getElement('span[itemprop="addressRegion"]', []);
  final _zipCode = webScraper.getElement('span[itemprop="postalCode"]', []);
  if (_streetAddress.isNotEmpty) {
    _address.add(_streetAddress.first['title']);
  }
  if (_city.isNotEmpty) {
    _address.add('${_city.first['title']}${_state.isNotEmpty ? ',' : ''}');
  }
  if (_state.isNotEmpty) {
    _address.add(_state.first['title']);
  }
  if (_zipCode.isNotEmpty) {
    _address.add(_zipCode.first['title']);
  }

  return _address.join(' ');
}

String _getPhone(WebScraper webScraper) {
  String _phone;

  final _elements = webScraper.getElement('span[itemprop="telephone"]', []);
  _elements.isNotEmpty ? _phone = _elements.first['title'] : _phone = '';

  return _phone;
}

String _getWebsite(WebScraper webScraper) {
  String _website;

  final _elements =
      webScraper.getElement('li.gz-card-website > a[itemprop="url"]', ['href']);
  _elements.isNotEmpty
      ? _website = _elements.first['attributes']['href']
      : _website = '';

  return _website;
}

String _getHours(WebScraper webScraper) {
  String _hours;

  final _elements = webScraper
      .getElement('div.gz-details-hours > p:not(.gz-details-subtitle)', []);
  _elements.isNotEmpty ? _hours = _elements.first['title'] : _hours = '';

  return _hours;
}

String _getHighlights(WebScraper webScraper) {
  final _highlights = <String>[];

  final _elements = webScraper.getElement('ul.gz-highlights-list > li', []);
  if (_elements.isNotEmpty) {
    for (final element in _elements) {
      _highlights.add(element['title']);
    }
  }

  return _highlights.join(';');
}
