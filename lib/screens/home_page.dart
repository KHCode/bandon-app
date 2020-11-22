import 'package:flutter/material.dart';
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
  var currentTemp = 72;
  var currentCondition = 'Sunny';
  var currentConditionIcon = BoxedIcon(WeatherIcons.day_sunny);

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  void _loadWeather() async {
    const CITY_NAME = 'Bandon';
    IconData conditionIcon;

    final secret = await SecretLoader(secretPath: 'openweather.json').load();
    final weatherFactory =
        WeatherFactory(secret.key, language: Language.ENGLISH);
    final currentWeather =
        await weatherFactory.currentWeatherByCityName(CITY_NAME);

    if (currentWeather.weatherConditionCode >= 200 &&
        currentWeather.weatherConditionCode < 300) {
      conditionIcon = WeatherIcons.thunderstorm;
    } else if (currentWeather.weatherConditionCode >= 300 &&
        currentWeather.weatherConditionCode < 400) {
      conditionIcon = WeatherIcons.sprinkle;
    } else if (currentWeather.weatherConditionCode >= 500 &&
        currentWeather.weatherConditionCode < 600) {
      conditionIcon = WeatherIcons.rain;
    } else if (currentWeather.weatherConditionCode >= 500 &&
        currentWeather.weatherConditionCode < 600) {
      conditionIcon = WeatherIcons.snow;
    } else if (currentWeather.weatherConditionCode == 800) {
      conditionIcon = WeatherIcons.day_sunny;
    } else if (currentWeather.weatherConditionCode > 800) {
      conditionIcon = WeatherIcons.cloud;
    }
    setState(() {
      currentTemp = currentWeather.temperature.fahrenheit.round();
      currentCondition = currentWeather.weatherDescription;
      currentConditionIcon = BoxedIcon(conditionIcon);
    });
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
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        currentConditionIcon,
                        Text(currentCondition),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          '${currentTemp.toString()}°',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ]),
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
            child: Image.asset(
                'assets/images/bandon-home-plan-your-visit-alt.jpg'),
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
}
