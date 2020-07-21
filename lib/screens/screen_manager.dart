import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/screens/settings_screen.dart';
import 'package:weight_tracker_app/screens/weight_screen.dart';
import 'package:weight_tracker_app/size_config.dart';
import 'package:weight_tracker_app/providers/preferences_data.dart';

class ScreenManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<PreferencesData>(context).checkAllPreferences();
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return FutureBuilder<bool>(
          future: Provider.of<PreferencesData>(context).checkAllPreferences(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              bool data = snapshot.data;
              if (data) {
                return WeightScreen();
              } else {
                return SettingsScreen(targetWeight: null, height: null, gender: null,);
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      });
    });
  }
}
