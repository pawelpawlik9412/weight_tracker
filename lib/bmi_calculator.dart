import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/providers/preferences_data.dart';
import 'package:weight_tracker_app/providers/weight_data.dart';

class BmiCalculator {

  static Future<Map> getBmiDetail(context) async {
    Map map = {};
    var bmi = await getBmi(context);
    map['bmi'] = bmi.toString();
    map['description'] = getBmiDescription(bmi);
    map['color'] = getBmiColor(bmi);
    map['chart'] = getBmiChart(bmi);




    return map;
  }


  static Future<double> getBmi(context) async {
    String heightString = await Provider.of<PreferencesData>(context).getHeightPreferences();
    double height = double.parse(heightString) / 100;
    double bmi = await Provider.of<WeightData>(context, listen: false).getLastWeight() / (height * height);
    var result = double.parse((bmi).toStringAsFixed(2));
    return result;
  }

  static String getBmiDescription(double bmi) {
    String description;
    if(bmi < 18.50) {
      description = 'YOU\'RE UNDERWEIGHT';
    } else if(bmi >= 18.50 && bmi < 25.00) {
      description = 'YOU\'VE THE PERFECT WEIGHT';
    } else if(bmi >= 25.00 && bmi < 30.00) {
      description = 'YOU\'RE OVERWEIGHT';
    } else if(bmi >= 30) {
      description = 'YOU\'RE OBESE';
    } else {
      description = '';
    }
    return description;
  }


  static Color getBmiColor(double bmi) {

    if(bmi < 18.5) {
      return Color(0xFF82BDE6);
    } else if(bmi >= 18.5 && bmi < 25.0) {
      return Color(0xFF61DCC9);
    } else if(bmi >= 25.0 && bmi < 30.0) {
      return Color(0xFFDAC479);
    } else if(bmi >= 30.0) {
      return Color(0xFFCD617B);
    }
  }

  static int getBmiChart(double bmi) {
    if(bmi < 14.00) {
      return 1;
    } else if(bmi < 14.50 && bmi >= 14.00) {
      return 2;
    } else if(bmi < 15.00 && bmi >= 14.50) {
      return 3;
    } else if(bmi < 15.50 && bmi >= 15.00) {
      return 4;
    } else if(bmi < 16.00 && bmi >= 15.50) {
      return 5;
    } else if(bmi < 16.50 && bmi >= 16.00) {
      return 6;
    } else if(bmi < 17.00 && bmi >= 16.50) {
      return 7;
    } else if(bmi < 17.50 && bmi >= 17.00) {
      return 8;
    } else if(bmi < 18.00 && bmi >= 17.50) {
      return 9;
    } else if(bmi < 18.50 && bmi >= 18.00) {
      return 10;
    } else if(bmi < 19.00 && bmi >= 18.50) {
      return 11;
    } else if(bmi < 19.50 && bmi >= 19.00) {
      return 12;
    } else if(bmi < 20.00 && bmi >= 19.50) {
      return 13;
    } else if(bmi < 20.50 && bmi >= 20.00) {
      return 14;
    } else if(bmi < 21.00 && bmi >= 20.50) {
      return 15;
    } else if(bmi < 21.50 && bmi >= 21.00) {
      return 16;
    } else if(bmi < 22.00 && bmi >= 21.50) {
      return 17;
    } else if(bmi < 22.50 && bmi >= 22.00) {
      return 18;
    } else if(bmi < 23.00 && bmi >= 22.50) {
      return 19;
    } else if(bmi < 23.50 && bmi >= 23.00) {
      return 20;
    } else if(bmi < 24.00 && bmi >= 23.50) {
      return 21;
    } else if(bmi < 24.50 && bmi >= 24.00) {
      return 22;
    } else if(bmi < 25.00 && bmi >= 24.50) {
      return 23;
    } else if(bmi < 25.50 && bmi >= 25.00) {
      return 24;
    } else if(bmi < 26.00 && bmi >= 25.50) {
      return 25;
    } else if(bmi < 26.50 && bmi >= 26.00) {
      return 26;
    } else if(bmi < 27.00 && bmi >= 26.50) {
      return 27;
    } else if(bmi < 27.50 && bmi >= 27.00) {
      return 28;
    } else if(bmi < 28.00 && bmi >= 27.50) {
      return 29;
    } else if(bmi < 28.50 && bmi >= 28.00) {
      return 30;
    } else if(bmi < 29.00 && bmi >= 28.50) {
      return 31;
    } else if(bmi < 29.50 && bmi >= 29.00) {
      return 32;
    } else if(bmi < 30.00 && bmi >= 29.50) {
      return 33;
    } else if(bmi < 30.50 && bmi >= 30.00) {
      return 34;
    } else if(bmi < 31.00 && bmi >= 30.50) {
      return 35;
    } else if(bmi < 31.50 && bmi >= 31.00) {
      return 36;
    } else if(bmi < 32.00 && bmi >= 31.50) {
      return 37;
    } else if(bmi < 32.50 && bmi >= 32.00) {
      return 38;
    } else if(bmi < 33.00 && bmi >= 32.50) {
      return 39;
    } else if(bmi < 33.50 && bmi >= 33.00) {
      return 40;
    } else if(bmi < 34.00 && bmi >= 33.50) {
      return 41;
    } else if(bmi < 34.50 && bmi >= 34.00) {
      return 42;
    } else if(bmi < 35.00 && bmi >= 34.50) {
      return 43;
    } else if(bmi < 35.50 && bmi >= 35.00) {
      return 44;
    } else if(bmi < 36.00 && bmi >= 35.50) {
      return 45;
    } else if(bmi < 36.50 && bmi >= 36.00) {
      return 46;
    } else if(bmi < 37.00 && bmi >= 36.50) {
      return 47;
    } else if(bmi < 37.50 && bmi >= 37.00) {
      return 48;
    } else if(bmi < 38.00 && bmi >= 37.50) {
      return 49;
    } else if(bmi < 38.50 && bmi >= 38.00) {
      return 50;
    } else if(bmi < 39.00 && bmi >= 38.50) {
      return 51;
    } else if(bmi < 39.50 && bmi >= 39.00) {
      return 52;
    } else if(bmi >= 39.50) {
      return 53;
    }
  }
}