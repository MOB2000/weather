import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/app_state_container.dart';
import 'package:weather/bloc/weather_bloc_observer.dart';
import 'package:weather/bloc/weather_bloc_provider.dart';
import 'package:weather/screens/settings_screen.dart';
import 'package:weather/screens/weather_screen.dart';

void main() {
  Bloc.observer = WeatherBlocObserver();

  runApp(
    const AppStateContainer(
      child: WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: AppStateContainer.of(context).theme,
      home: BlocProvider(
        create: (context) => WeatherBloc(),
        child: const WeatherScreen(),
      ),
      routes: <String, WidgetBuilder>{
        '/home': (context) => const WeatherScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
