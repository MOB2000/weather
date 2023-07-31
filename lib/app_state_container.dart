import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/themes.dart';
import 'package:weather/utils/constants.dart';
import 'package:weather/utils/converters.dart';

class AppStateContainer extends StatefulWidget {
  final Widget child;

  const AppStateContainer({
    super.key,
    required this.child,
  });

  @override
  State<AppStateContainer> createState() => AppStateContainerState();

  static AppStateContainerState of(BuildContext context) {
    var widget =
        context.dependOnInheritedWidgetOfExactType<_InheritedStateContainer>();
    return widget!.data;
  }
}

class AppStateContainerState extends State<AppStateContainer> {
  ThemeData _theme = Themes.getTheme(Themes.kDarkThemeCode);
  int themeCode = Themes.kDarkThemeCode;
  TemperatureUnit temperatureUnit = TemperatureUnit.celsius;

  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPref) {
      setState(() {
        themeCode =
            sharedPref.getInt(CONSTANTS.kThemeCode) ?? Themes.kDarkThemeCode;
        temperatureUnit = TemperatureUnit.values[
            sharedPref.getInt(CONSTANTS.kTemperatureUnit) ??
                TemperatureUnit.celsius.index];
        _theme = Themes.getTheme(themeCode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  ThemeData get theme => _theme;

  updateTheme(int themeCode) {
    setState(() {
      _theme = Themes.getTheme(themeCode);
      this.themeCode = themeCode;
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(CONSTANTS.kThemeCode, themeCode);
    });
  }

  updateTemperatureUnit(TemperatureUnit unit) {
    setState(() {
      temperatureUnit = unit;
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(CONSTANTS.kTemperatureUnit, unit.index);
    });
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final AppStateContainerState data;

  const _InheritedStateContainer({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) => true;
}
