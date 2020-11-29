import 'package:bandon/screens/find-business.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_icons/weather_icons.dart';

import 'dining.dart';
import 'lodging.dart';
import '../models/secret_loader.dart';
import '../widgets/app_gradient_background.dart';
import '../widgets/settings_drawer.dart';
import '../widgets/styled_section_banner.dart';
import '../widgets/padded_text_body.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  final String title;

  HomePage({Key key, @required this.title}) : super(key: key);

  static const bodyAbout = [
    'Life in Bandon is shaped by nature and the people who make their home in this corner of the Oregon Coast.',
    'That’s why we say our attractions are always in season, always open.',
    'Stunning ocean vistas. Wild woods and streams. Friendly neighbors who understand you want to pace yourself, take it all in.',
    'Enjoy year-round fishing, cycling, golf, hiking and beach going. Our landscapes are green. Our air is clean, and the temps are moderate all year. If the wind picks up, just bundle up– and experience some of the most dramatic storm watching in Oregon.',
    'If you’re planning a visit to Bandon, you’ve found our home on the web. Feel free to contact us for more information. The Bandon Chamber of Commerce and Visitors Center office is open daily',
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentConditionWidget = <Widget>[];
  final forecastWidgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  void _loadWeather() async {
    const CITY_NAME = 'Bandon';
    final threeDayForecast = <Weather>[];
    var dateTime = DateTime.now();

    final secret = await SecretLoader(secretPath: 'openweather.json').load();
    final weatherFactory =
        WeatherFactory(secret.key, language: Language.ENGLISH);
    final currentWeather =
        await weatherFactory.currentWeatherByCityName(CITY_NAME);
    final forecast = await weatherFactory.fiveDayForecastByCityName(CITY_NAME);

    currentConditionWidget.clear();
    currentConditionWidget.addAll(
      [
        Expanded(
          child: Center(
            child: Column(
              children: [
                BoxedIcon(
                    getConditionIcon(currentWeather.weatherConditionCode)),
                Text('${currentWeather.weatherDescription}'),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              children: [
                Text(
                  '${currentWeather.temperature.fahrenheit.round()}°',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ),
      ],
    );

    for (var _ = 0; _ < 3; _++) {
      final midDayForecast = forecast.firstWhere(
          (forecast) =>
              (forecast.date.day == dateTime.day && forecast.date.hour >= 11),
          orElse: () => null);

      if (midDayForecast?.temperature?.fahrenheit?.isFinite ?? false) {
        threeDayForecast.add(midDayForecast);
      }

      dateTime = dateTime.add(Duration(days: 1));
    }

    dateTime = DateTime.now();
    forecastWidgets.clear();
    for (final day in threeDayForecast) {
      forecastWidgets.add(
        Expanded(
          child: Center(
            child: Column(
              children: [
                BoxedIcon(getConditionIcon(day.weatherConditionCode)),
                Text('${day.temperature.fahrenheit.round()}°'),
                Text(DateFormat('EEEE').format(dateTime)),
              ],
            ),
          ),
        ),
      );
      dateTime = dateTime.add(Duration(days: 1));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      endDrawer: const SettingsDrawer(),
      body: Container(
        decoration: gradientBackground(context),
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Image.asset(
                'assets/images/bandon-logo-${Theme.of(context).brightness == Brightness.dark ? 'light' : 'dark'}.png'),
          ),
          Image.asset('assets/images/beach-sunset.jpg'),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: currentConditionWidget,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: forecastWidgets,
              ),
            ],
          ),
          StyledSectionBanner(
            leftText: 'About',
            rightText: 'Bandon Oregon',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Image.asset('assets/images/separator.png'),
          ),
          PaddedTextBody(textBody: HomePage.bodyAbout),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: InkWell(
              child: Image.asset(
                  'assets/images/bandon-home-plan-your-visit-alt.jpg'),
              onTap: () =>
                  Navigator.of(context).pushNamed(FindBusinessScreen.routeName),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: InkWell(
              child: Image.asset(
                  'assets/images/bandon-home-choose-your-table-green.jpg'),
              onTap: () =>
                  Navigator.of(context).pushNamed(DiningScreen.routeName),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: InkWell(
              child:
                  Image.asset('assets/images/bandon-home-book-your-stay.jpg'),
              onTap: () =>
                  Navigator.of(context).pushNamed(LodgingScreen.routeName),
            ),
          ),
        ]),
      ),
    );
  }

  IconData getConditionIcon(int conditionCode) {
    IconData conditionIcon;

    if (conditionCode >= 200 && conditionCode < 300) {
      conditionIcon = WeatherIcons.thunderstorm;
    } else if (conditionCode >= 300 && conditionCode < 400) {
      conditionIcon = WeatherIcons.sprinkle;
    } else if (conditionCode >= 500 && conditionCode < 600) {
      conditionIcon = WeatherIcons.rain;
    } else if (conditionCode >= 600 && conditionCode < 700) {
      conditionIcon = WeatherIcons.snow;
    } else if (conditionCode >= 700 && conditionCode < 800) {
      conditionIcon = WeatherIcons.fog;
    } else if (conditionCode == 800) {
      conditionIcon = WeatherIcons.day_sunny;
    } else if (conditionCode > 800) {
      conditionIcon = WeatherIcons.cloud;
    } else {
      conditionIcon = WeatherIcons.day_sunny;
    }
    return conditionIcon;
  }
}
