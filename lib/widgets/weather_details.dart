import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/app_state_container.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/widgets/value_tile.dart';

class WeatherDetails extends StatelessWidget {
  final Weather weather;

  const WeatherDetails({
    super.key,
    required this.weather,
  });

  String formatTime(int? time) {
    return DateFormat('h:m a').format(
      DateTime.fromMillisecondsSinceEpoch(time ?? 0 * 1000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ValueTile(
          label: "wind speed",
          value: '${weather.windSpeed} m/s',
        ),
        const CustomTilesDivider(),
        ValueTile(
          label: "sunrise",
          value: formatTime(weather.sunrise),
        ),
        const CustomTilesDivider(),
        ValueTile(
          label: "sunset",
          value: formatTime(weather.sunset),
        ),
        const CustomTilesDivider(),
        ValueTile(
          label: "humidity",
          value: '${weather.humidity}%',
        ),
      ],
    );
  }
}

class CustomTilesDivider extends StatelessWidget {
  const CustomTilesDivider({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Container(
          width: 1,
          height: 30,
          color: appTheme.colorScheme.secondary.withAlpha(50),
        ),
      ),
    );
  }
}
