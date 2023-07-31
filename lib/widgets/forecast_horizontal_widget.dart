import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/app_state_container.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/widgets/value_tile.dart';

class ForecastHorizontal extends StatelessWidget {
  final List<Weather> weathers;

  const ForecastHorizontal({
    Key? key,
    required this.weathers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: weathers.length,
        separatorBuilder: (context, index) => const Divider(
          height: 100,
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index) {
          final item = weathers[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: ValueTile(
                label: DateFormat('E, ha').format(
                    DateTime.fromMillisecondsSinceEpoch(item.time * 1000)),
                value:
                    '${item.temperature.as(AppStateContainer.of(context).temperatureUnit).round()}°',
                iconData: item.getIconData(),
              ),
            ),
          );
        },
      ),
    );
  }
}
