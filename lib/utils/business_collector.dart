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
        print('Skipping the business at $businessUrl');
      } else {
        databaseManager.saveBusiness(dto: _business);
      }
    }
    return _businesses.isNotEmpty ? true : false;
  }

  Future<List<String>> _getBusinessUrls() async {
    const MAX_FAILURES = 10;
    var _businessId = 1;
    var _consecutiveFailures = 0;

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
      _newBusiness.name = _getName(_webScraper);

      // Return a null object if the business name isn't published
      if (_newBusiness?.name?.isEmpty ?? true) {
        return BusinessDTO.nullBusiness();
      }
      _newBusiness.address = _getAddress(_webScraper);
      _newBusiness.phone = _getPhone(_webScraper);

      // Return a null object if there is no contact information
      // (a PO Box or no address at all)
      if (_newBusiness.phone.isEmpty &&
              (_newBusiness.address
                  .contains(RegExp(r'P\.*O\.*\s+BOX', caseSensitive: false))) ||
          _newBusiness.address.isEmpty) {
        return BusinessDTO.nullBusiness();
      }
      _newBusiness.aboutUs = _getAboutUs(_webScraper);
      _newBusiness.categories = _getCategories(_webScraper);

      // Return a null object if the business isn't categorized or described
      // (this indicates an individual member, not a business listing)
      if (_newBusiness.aboutUs.isEmpty && _newBusiness.categories.isEmpty) {
        return BusinessDTO.nullBusiness();
      }
      _newBusiness.permalink = businessUrl;
      _newBusiness.website = _getWebsite(_webScraper);
      _newBusiness.hours = _getHours(_webScraper);
      _newBusiness.highlights = _getHighlights(_webScraper);
    } else {
      print('Failed to load the business');
      return BusinessDTO.nullBusiness();
    }

    return _newBusiness;
  }

  String _getName(WebScraper webScraper) {
    String _name;

    final _elements = webScraper.getElement('h1.gz-pagetitle', []);
    _elements.isNotEmpty ? _name = _elements.first['title'].trim() : _name = '';

    return _name;
  }

  String _getCategories(WebScraper webScraper) {
    final _categories = <String>[];

    final _elements = webScraper.getElement('span.gz-cat', []);
    for (final element in _elements) {
      _categories.add(element['title'].trim());
    }

    return _categories.join(';');
  }

  String _getAboutUs(WebScraper webScraper) {
    final expressions = [
      RegExp(r'([a-z]{2,})([A-Z]+[a-z]*)'),
      RegExp(r'([A-Za-z]{2,}\.)([A-Z]+[a-z]*)'),
      RegExp(r'(\s{2,})([A-Z]+[a-z]*)'),
      RegExp(r'([aApP]\.*[mM]\.*)([A-Z0-9])'),
      RegExp(r'([1-2][0-9]{3}\.)([A-Z]+[a-z]*)'),
      RegExp(r'(!|\?+)([A-Z]+[a-z]*)'),
    ];
    String _aboutUs;

    final _elements =
        webScraper.getElement('div.gz-details-about > div > p', []);
    _elements.isNotEmpty
        ? _aboutUs = _elements.first['title'].trim()
        : _aboutUs = '';

    if (_aboutUs.isNotEmpty) {
      for (final exp in expressions) {
        _aboutUs = _aboutUs.replaceAllMapped(
            exp, (Match match) => '${match[1]}\n\n${match[2]}');
      }
    }

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
    _address.add(_streetAddress.first['title'].trim());
  }
  if (_city.isNotEmpty) {
    _address
        .add('${_city.first['title'].trim()}${_state.isNotEmpty ? ',' : ''}');
  }
  if (_state.isNotEmpty) {
    _address.add(_state.first['title'].trim());
  }
  if (_zipCode.isNotEmpty) {
    _address.add(_zipCode.first['title'].trim());
  }

  return _address.join(' ');
}

String _getPhone(WebScraper webScraper) {
  String _phone;

  var _elements = webScraper.getElement('span[itemprop="telephone"]', []);
  if (_elements.isEmpty) {
    _elements = webScraper.getElement('span[itemprop="tollfree"]', []);
  }
  _elements.isNotEmpty ? _phone = _elements.first['title'].trim() : _phone = '';

  return _phone;
}

String _getWebsite(WebScraper webScraper) {
  String _website;

  final _elements =
      webScraper.getElement('li.gz-card-website > a[itemprop="url"]', ['href']);
  _elements.isNotEmpty
      ? _website = _elements.first['attributes']['href'].trim()
      : _website = '';

  return _website;
}

String _getHours(WebScraper webScraper) {
  final expressions = [
    RegExp(r'([a-z]{2,})([A-Z]+[a-z]*)'),
    RegExp(r'([A-Za-z]{2,}\.)([A-Z]+[a-z]*)'),
    RegExp(r'(\s{2,})([A-Z]+[a-z]*)'),
    RegExp(r'([aApP]\.*[mM]\.*)([A-Z0-9])'),
    RegExp(r'([1-2][0-9]{3}\.)([A-Z]+[a-z]*)'),
    RegExp(r'(!|\?+)([A-Z]+[a-z]*)'),
  ];
  String _hours;

  final _elements = webScraper
      .getElement('div.gz-details-hours > p:not(.gz-details-subtitle)', []);
  _elements.isNotEmpty ? _hours = _elements.first['title'].trim() : _hours = '';

  if (_hours.isNotEmpty) {
    for (final exp in expressions) {
      _hours = _hours.replaceAllMapped(
          exp, (Match match) => '${match[1]}\n\n${match[2]}');
    }
  }

  return _hours;
}

String _getHighlights(WebScraper webScraper) {
  final _highlights = <String>[];

  final _elements = webScraper.getElement('ul.gz-highlights-list > li', []);

  for (final element in _elements) {
    _highlights.add(element['title'].trim());
  }

  return _highlights.join(';');
}
