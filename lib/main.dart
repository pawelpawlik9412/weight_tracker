import 'package:flutter/material.dart';
import 'package:weight_tracker_app/providers/preferences_data.dart';
import 'package:weight_tracker_app/screens/screen_manager.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/providers/weight_data.dart';

void main() => runApp(WeightApp());

class WeightApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PreferencesData()),
        ChangeNotifierProvider(create: (_) => WeightData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFF16172E),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: ScreenManager(),
          ),
        ),
      ),
    );
  }
}
