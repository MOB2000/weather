import 'package:flutter/material.dart';
import 'package:weather/app_state_container.dart';

enum OptionsMenu { changeCity, settings }

class PopUpMenu extends StatefulWidget {
  final Function(String) onChangeCity;
  final Function onFetchWeatherWithCity;
  final Function onFetchWeatherWithLocation;

  const PopUpMenu({
    super.key,
    required this.onChangeCity,
    required this.onFetchWeatherWithCity,
    required this.onFetchWeatherWithLocation,
  });

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return PopupMenuButton<OptionsMenu>(
      color: appTheme.primaryColor,
      onSelected: _onOptionMenuItemSelected,
      itemBuilder: (context) => <PopupMenuEntry<OptionsMenu>>[
        PopupMenuItem<OptionsMenu>(
          value: OptionsMenu.changeCity,
          child: Text(
            "change city",
            style: TextStyle(color: appTheme.colorScheme.secondary),
          ),
        ),
        PopupMenuItem<OptionsMenu>(
          value: OptionsMenu.settings,
          child: Text(
            "settings",
            style: TextStyle(color: appTheme.colorScheme.secondary),
          ),
        ),
      ],
      child: Icon(
        Icons.more_vert,
        color: appTheme.colorScheme.secondary,
      ),
    );
  }

  _onOptionMenuItemSelected(OptionsMenu item) {
    switch (item) {
      case OptionsMenu.changeCity:
        _showCityChangeDialog();
        break;
      case OptionsMenu.settings:
        Navigator.of(context).pushNamed("/settings");
        break;
    }
  }

  void _showCityChangeDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        ThemeData appTheme = AppStateContainer.of(context).theme;

        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Change city',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: appTheme.colorScheme.secondary,
                elevation: 1,
              ),
              onPressed: () {
                widget.onFetchWeatherWithCity();
                Navigator.of(context).pop();
              },
              child: const Text('ok'),
            ),
          ],
          content: TextField(
            autofocus: true,
            onChanged: widget.onChangeCity,
            decoration: InputDecoration(
              hintText: 'Name of your city',
              hintStyle: const TextStyle(color: Colors.black),
              suffixIcon: GestureDetector(
                onTap: () {
                  widget.onFetchWeatherWithLocation();

                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.my_location,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ),
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
          ),
        );
      },
    );
  }
}
