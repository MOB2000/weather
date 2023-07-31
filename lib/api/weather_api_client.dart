import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/api/http_exception.dart';
import 'package:weather/api/key.dart';
import 'package:weather/model/weather.dart';

class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';

  Uri _buildUri(String endpoint, Map<String, String> queryParameters) {
    var query = {'appid': kOpenWeatherMapApiKey};

    query = query..addAll(queryParameters);

    var uri = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: 'data/2.5/$endpoint',
      queryParameters: query,
    );

    return uri;
  }

  Future<String> getCityNameFromLocation({
    required double latitude,
    required double longitude,
  }) async {
    final uri = _buildUri('weather', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
    });

    final res = await http.Client().get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final weatherJson = json.decode(res.body);
    return weatherJson['name'];
  }

  Future<Weather> getWeatherData(String cityName) async {
    final uri = _buildUri('weather', {'q': cityName});

    final res = await http.Client().get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }

  Future<List<Weather>> getForecast(String cityName) async {
    final uri = _buildUri('forecast', {'q': cityName});

    final res = await http.Client().get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final forecastJson = json.decode(res.body);
    List<Weather> weathers = Weather.fromForecastJson(forecastJson);
    return weathers;
  }
}
