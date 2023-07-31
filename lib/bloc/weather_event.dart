import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final String? cityName;
  final double? longitude;
  final double? latitude;

  const FetchWeather({
    this.cityName,
    this.longitude,
    this.latitude,
  });

  @override
  List<Object?> get props => [cityName, longitude, latitude];
}
