import 'package:flutter/material.dart';
import 'package:weather/utils/converters.dart';
import 'package:weather/utils/weather_icon_mapper.dart';

class Weather {
  int? id;
  int time;
  int? sunrise;
  int? sunset;
  int? humidity;

  String? description;
  String iconCode;
  String? main;
  String? cityName;

  double? windSpeed;

  Temperature temperature;
  Temperature? maxTemperature;
  Temperature? minTemperature;

  List<Weather> forecast = List.empty(growable: true);

  Weather({
    this.id,
    required this.time,
    this.sunrise,
    this.sunset,
    this.humidity,
    this.description,
    required this.iconCode,
    this.main,
    this.cityName,
    this.windSpeed,
    required this.temperature,
    this.maxTemperature,
    this.minTemperature,
    required this.forecast,
  });

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temperature: Temperature(intToDouble(json['main']['temp'])),
      maxTemperature: Temperature(intToDouble(json['main']['temp_max'])),
      minTemperature: Temperature(intToDouble(json['main']['temp_min'])),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: json['main']['humidity'],
      windSpeed: intToDouble(json['wind']['speed']),
      forecast: List.empty(growable: true),
    );
  }

  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    final weathers = List<Weather>.empty(growable: true);
    for (final item in json['list']) {
      weathers.add(
        Weather(
          time: item['dt'],
          temperature: Temperature(intToDouble(
            item['main']['temp'],
          )),
          iconCode: item['weather'][0]['icon'],
          forecast: List.empty(growable: true),
        ),
      );
    }
    return weathers;
  }

  IconData getIconData() {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.kClearDay;
      case '01n':
        return WeatherIcons.kClearNight;
      case '02d':
        return WeatherIcons.kFewCloudsDay;
      case '02n':
        return WeatherIcons.kFewCloudsDay;
      case '03d':
      case '04d':
        return WeatherIcons.kCloudsDay;
      case '03n':
      case '04n':
        return WeatherIcons.kClearNight;
      case '09d':
        return WeatherIcons.kShowerRainDay;
      case '09n':
        return WeatherIcons.kShowerRainNight;
      case '10d':
        return WeatherIcons.rkRainDay;
      case '10n':
        return WeatherIcons.kRainNight;
      case '11d':
        return WeatherIcons.kThunderStormDay;
      case '11n':
        return WeatherIcons.kThunderStormNight;
      case '13d':
        return WeatherIcons.kSnowDay;
      case '13n':
        return WeatherIcons.kSnowNight;
      case '50d':
        return WeatherIcons.kMistDay;
      case '50n':
        return WeatherIcons.kMistNight;
      default:
        return WeatherIcons.kClearDay;
    }
  }
}
