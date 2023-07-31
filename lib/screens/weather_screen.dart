import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/app_state_container.dart';
import 'package:weather/bloc/weather_bloc_provider.dart';
import 'package:weather/bloc/weather_event.dart';
import 'package:weather/bloc/weather_state.dart';
import 'package:weather/widgets/pop_up_menu.dart';
import 'package:weather/widgets/weather_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  late WeatherBloc _weatherBloc;
  String _cityName = 'Rafah';
  late Animation<double> _fadeAnimation;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();

    _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    _fetchWeatherWithLocation().catchError((error) {
      _fetchWeatherWithCity();
    });

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppStateContainer.of(context).theme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: appTheme.primaryColor,
        elevation: 0,
        title: Text(
          DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
          style: TextStyle(
            color: appTheme.colorScheme.secondary.withAlpha(80),
            fontSize: 14,
          ),
        ),
        actions: <Widget>[
          PopUpMenu(
            onChangeCity: (text) {
              _cityName = text;
            },
            onFetchWeatherWithCity: _fetchWeatherWithCity,
            onFetchWeatherWithLocation: () =>
                _fetchWeatherWithLocation().catchError((error) {
              _fetchWeatherWithCity();
            }),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Material(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(color: appTheme.primaryColor),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (_, WeatherState weatherState) {
                _fadeController.reset();
                _fadeController.forward();

                if (weatherState is WeatherLoaded) {
                  _cityName = weatherState.weather.cityName!;
                  return WeatherWidget(
                    weather: weatherState.weather,
                  );
                } else if (weatherState is WeatherError ||
                    weatherState is WeatherEmpty) {
                  String errorText = 'There was an error fetching weather data';
                  if (weatherState is WeatherError) {
                    if (weatherState.errorCode == 404) {
                      errorText =
                          'We have trouble fetching weather for $_cityName';
                    }
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 24,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        errorText,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: appTheme.colorScheme.secondary,
                          elevation: 1,
                        ),
                        onPressed: _fetchWeatherWithCity,
                        child: const Text("Try Again"),
                      ),
                    ],
                  );
                } else if (weatherState is WeatherLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: appTheme.primaryColor,
                    ),
                  );
                }
                return const Text('No city set');
              },
            ),
          ),
        ),
      ),
    );
  }

  _fetchWeatherWithCity() {
    _weatherBloc.add(FetchWeather(cityName: _cityName));
  }

  _fetchWeatherWithLocation() async {
    var permissionResult = await Permission.locationWhenInUse.status;

    switch (permissionResult) {
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        _showLocationDeniedDialog();
        break;

      case PermissionStatus.denied:
        await Permission.locationWhenInUse.request();
        _fetchWeatherWithLocation();
        break;

      case PermissionStatus.limited:
      case PermissionStatus.granted:
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
          timeLimit: const Duration(seconds: 2),
        );

        _weatherBloc.add(
          FetchWeather(
            longitude: position.longitude,
            latitude: position.latitude,
          ),
        );
        break;
      default:
        throw Exception("Exception in permission type");
    }
  }

  void _showLocationDeniedDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        ThemeData appTheme = AppStateContainer.of(context).theme;

        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Location is disabled :(',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: appTheme.colorScheme.secondary,
                elevation: 1,
              ),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: const Text('Enable!'),
            ),
          ],
        );
      },
    );
  }
}
