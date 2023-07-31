import 'package:flutter/material.dart';
import 'package:weather/app_state_container.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/widgets/current_conditions.dart';
import 'package:weather/widgets/forecast_horizontal_widget.dart';
import 'package:weather/widgets/weather_details.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            weather.cityName!,
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 5,
              color: appTheme.colorScheme.secondary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            weather.description?.toUpperCase() ?? "",
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 5,
              fontWeight: FontWeight.w100,
              color: appTheme.colorScheme.secondary,
            ),
          ),
          Expanded(child: CurrentConditions(weather: weather)),
          const _DividerWidget(),
          ForecastHorizontal(weathers: weather.forecast),
          const _DividerWidget(),
          WeatherDetails(weather: weather),
        ],
      ),
    );
  }
}

class _DividerWidget extends StatelessWidget {
  const _DividerWidget();

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Divider(color: appTheme.colorScheme.secondary.withAlpha(50)),
    );
  }
}
