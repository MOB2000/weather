import 'package:flutter/material.dart';
import 'package:weather/app_state_container.dart';
import 'package:weather/widgets/empty_widget.dart';

class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData? iconData;

  const ValueTile({
    super.key,
    required this.label,
    required this.value,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: appTheme.colorScheme.secondary.withAlpha(80)),
        ),
        const SizedBox(height: 5),
        if (iconData == null)
          const EmptyWidget()
        else
          Icon(
            iconData,
            color: appTheme.colorScheme.secondary,
            size: 20,
          ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(color: appTheme.colorScheme.secondary),
        ),
      ],
    );
  }
}
