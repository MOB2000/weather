import 'package:weather/api/weather_api_client.dart';
import 'package:weather/model/weather.dart';

class WeatherRepository {
  final WeatherApiClient _weatherApiClient = WeatherApiClient();

  Future<Weather> getWeather({
    String? cityName,
    double? latitude,
    double? longitude,
  }) async {
    cityName ??= await _weatherApiClient.getCityNameFromLocation(
      latitude: latitude!,
      longitude: longitude!,
    );

    var weather = await _weatherApiClient.getWeatherData(cityName);
    var weathers = await _weatherApiClient.getForecast(cityName);
    weather.forecast = weathers;
    return weather;
  }
}
