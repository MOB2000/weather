import 'package:flutter/material.dart';

class _IconData extends IconData {
  const _IconData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'WeatherIcons',
        );
}

class WeatherIcons {
  static const IconData kClearDay = _IconData(0xf00d);
  static const IconData kClearNight = _IconData(0xf02e);

  static const IconData kFewCloudsDay = _IconData(0xf002);
  static const IconData kFewCloudsNight = _IconData(0xf081);

  static const IconData kCloudsDay = _IconData(0xf07d);
  static const IconData kCloudsNight = _IconData(0xf080);

  static const IconData kShowerRainDay = _IconData(0xf009);
  static const IconData kShowerRainNight = _IconData(0xf029);

  static const IconData rkRainDay = _IconData(0xf008);
  static const IconData kRainNight = _IconData(0xf028);

  static const IconData kThunderStormDay = _IconData(0xf010);
  static const IconData kThunderStormNight = _IconData(0xf03b);

  static const IconData kSnowDay = _IconData(0xf00a);
  static const IconData kSnowNight = _IconData(0xf02a);

  static const IconData kMistDay = _IconData(0xf003);
  static const IconData kMistNight = _IconData(0xf04a);
}
