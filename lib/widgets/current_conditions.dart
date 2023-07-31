import 'package:flutter/material.dart';
import 'package:weather/app_state_container.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/utils/converters.dart';
import 'package:weather/widgets/value_tile.dart';

class CurrentConditions extends StatelessWidget {
  final Weather weather;

  const CurrentConditions({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;
    TemperatureUnit unit = AppStateContainer.of(context).temperatureUnit;

    int currentTemp = weather.temperature.as(unit).round();
    int maxTemp = weather.maxTemperature?.as(unit).round() ?? 0;
    int minTemp = weather.minTemperature?.as(unit).round() ?? 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          color: appTheme.colorScheme.secondary,
          size: 70,
        ),
        const SizedBox(height: 20),
        Text(
          '$currentTemp°',
          style: TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.w100,
            color: appTheme.colorScheme.secondary,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueTile(label: "max", value: '$maxTemp'),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                child: Container(
                  width: 1,
                  height: 10,
                  color: appTheme.colorScheme.secondary.withAlpha(50),
                ),
              ),
            ),
            ValueTile(label: "min", value: '$minTemp°'),
          ],
        ),
      ],
    );
  }
}
