import 'package:flutter/material.dart';
import 'package:weather/app_state_container.dart';
import 'package:weather/themes.dart';
import 'package:weather/utils/converters.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateContainer.of(context);
    ThemeData appTheme = appState.theme;

    return Scaffold(
      appBar: AppBar(
        iconTheme:
            appTheme.iconTheme.copyWith(color: appTheme.colorScheme.secondary),
        backgroundColor: appTheme.primaryColor,
        title: Text(
          "Settings",
          style: TextStyle(color: appTheme.colorScheme.secondary),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        color: appTheme.primaryColor,
        child: ListView(
          children: <Widget>[
            const _SettingsTitleText(title: "Theme"),
            _SettingsTile<int>(
              isTop: true,
              label: "Dark",
              value: Themes.kDarkThemeCode,
              groupValue: appState.themeCode,
              onChanged: (value) => appState.updateTheme(value!),
            ),
            const _SettingsDivider(),
            _SettingsTile<int>(
              isBottom: true,
              label: "Light",
              value: Themes.kLightThemeCode,
              groupValue: appState.themeCode,
              onChanged: (value) => appState.updateTheme(value!),
            ),
            const _SettingsTitleText(title: "Unit"),
            _SettingsTile<int>(
              isTop: true,
              label: "Celsius",
              value: TemperatureUnit.celsius.index,
              groupValue: appState.temperatureUnit.index,
              onChanged: (value) => appState
                  .updateTemperatureUnit(TemperatureUnit.values[value!]),
            ),
            const _SettingsDivider(),
            _SettingsTile<int>(
              label: "Fahrenheit",
              value: TemperatureUnit.fahrenheit.index,
              groupValue: appState.temperatureUnit.index,
              onChanged: (value) => appState
                  .updateTemperatureUnit(TemperatureUnit.values[value!]),
            ),
            const _SettingsDivider(),
            _SettingsTile<int>(
              isBottom: true,
              label: "Kelvin",
              value: TemperatureUnit.kelvin.index,
              groupValue: appState.temperatureUnit.index,
              onChanged: (value) => appState
                  .updateTemperatureUnit(TemperatureUnit.values[value!]),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTitleText extends StatelessWidget {
  final String title;

  const _SettingsTitleText({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 12),
      child: Text(
        title,
        style: TextStyle(
          color: appTheme.colorScheme.secondary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;
    return Divider(color: appTheme.primaryColor, height: 1);
  }
}

class _SettingsTile<T> extends StatelessWidget {
  final String label;
  final T value;
  final T groupValue;
  final Function(T?) onChanged;
  final bool isTop;
  final bool isBottom;

  const _SettingsTile(
      {super.key,
      required this.label,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      this.isTop = false,
      this.isBottom = false});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateContainer.of(context);
    ThemeData appTheme = appState.theme;

    return Container(
      decoration: BoxDecoration(
        color: appTheme.colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isTop ? 8 : 0),
          topRight: Radius.circular(isTop ? 8 : 0),
          bottomLeft: Radius.circular(isBottom ? 8 : 0),
          bottomRight: Radius.circular(isBottom ? 8 : 0),
        ),
      ),
      child: RadioListTile<T>(
        controlAffinity: ListTileControlAffinity.trailing,
        title: Text(
          label,
          style: TextStyle(color: appTheme.colorScheme.secondary),
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: appTheme.colorScheme.secondary,
      ),
    );
  }
}
