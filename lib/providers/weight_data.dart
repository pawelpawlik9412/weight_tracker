import 'package:flutter/cupertino.dart';
import 'package:weight_tracker_app/database/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/providers/preferences_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weight_tracker_app/date.dart';
import 'package:weight_tracker_app/model/weight.dart';
import 'dart:math';



class WeightData extends ChangeNotifier {

  var _db = DatabaseHelper.db;

  get getDB {
    return _db.database;
  }

  void addWeight(Weight weight) {
    _db.insertWeigh(weight);
    notifyListeners();
  }

  Future<Map> getDataForWeightProgress(context) async {
    var targetWeight = await Provider.of<PreferencesData>(context, listen: false).getWeightTargetPreferences();
    var currentWeight = await _db.getLastWeightFromDatabase();
    var maxWeight = await _db.getMaxWeightFromDatabase();
    var progress = countWeightProgress(double.parse(targetWeight), currentWeight, maxWeight);

    Map map = {
      'targetWeight': targetWeight,
      'currentWeight': currentWeight,
      'maxWeight': maxWeight,
      'progress': progress,
    };

    if (map['targetWeight'] == null || map['currentWeight'] == null || map['maxWeight'] == null || map['progress'] == null) {
      map = null;
    }
    return map;
  }

  double countWeightProgress(double targetWeight, double currentWeight, double maxWeight) {
    var result;
    try {
      var toAchieveTarget = maxWeight - targetWeight;
      var currentDifference = currentWeight - targetWeight;
      result = (100 - (100 * currentDifference) / toAchieveTarget) / 100;
      if(result > 1.0) {
        result = 1.0;
      }
      else if (result < 0) {
        result = 1.0;
      }
    } catch(e) {
      print(e);
      result = null;
    }
    return result;
  }

  Future getLastWeight() async {
    var x = await _db.getLastWeightFromDatabase();
    return x;
  }

  Future getHistoryDataWeight(int limit) async {
    Map map = {};
    var y = await _db.getNumberOfRows();
    var x =  await _db.getWeightDataHistory(limit);
    map['numberOfRows'] = y;
    map['historyDataWeight'] = x;
    return map;
  }

  Future getAllHistoryDataWeight() async {
    var x =  await _db.getAllWeightDataHistory();
    return x;
  }




  Future<Map> getWeightDetailForChart(context) async {
    var limit = int.parse(await Provider.of<PreferencesData>(context).getTimeRangePreferences());
    Map<String, dynamic> map = {};
    var x = await _db;

    if(limit == 7 || limit == 30) {
      var spots = await getFlSpot(limit);
      var dates = await getDatesForChart(limit);
      var month = await getMonthForChart(limit);
      map['min weight'] = await x.getMinWeightFromLimit(limit);
      map['max weight'] = await x.getMaxWeightFromLimit(limit);
      map['fl spots'] = spots;
      map['last fl spot'] = spots[spots.length - 1];
      map['dates'] = dates;
      map['month'] = month;
      map['range'] = limit;

      return map;
    }
    else {

      var data = await x.getDataForChartLongTimeRange(limit);
      List listOfWeights;
      List dates;
      if(limit == 183) {
        listOfWeights = data.values.toList().sublist(0, 7);
        dates = data.keys.toList().sublist(0, 7);
      } else {
        listOfWeights = data.values.toList().sublist(0, 13);
        dates = data.keys.toList().sublist(0, 13);

      }
      List<FlSpot> spots = [];
      for (var i = 0; i < listOfWeights.length; i++) {
        spots.add(FlSpot(i.toDouble(), listOfWeights[i]));
      }

      List<String> month = [];
      for(var u in dates) {
       month.add(Date.getShortMonthName(int.parse(u.substring(5, 7))));
      }

      List<String> monthList =  List.from(month.reversed);
      List datesList = List.from(dates.reversed);


      double minWeight = listOfWeights.reduce((value, element) => value < element ? value : element);
      double maxWeight = listOfWeights.reduce((value, element) => value > element ? value : element);
      map['min weight'] = minWeight;
      map['max weight'] = maxWeight;
      map['range'] = limit;
      map['fl spots'] = spots;
      map['last fl spot'] = spots[spots.length - 1];
      map['dates'] = datesList;
      map['month'] = monthList;

      return map;

    }

  }

  Future<List> getFlSpot(limit) async {
    var x = await _db.getWeightForChar(limit);
    var y = List.from(x.reversed);

    List<FlSpot> list = [];
    for (var i = 0; i < y.length; i++) {
      list.add(FlSpot(i.toDouble(), y[i].toMap()['weight']));
    }
    return list;
  }

  Future<List> getDatesForChart(limit) async {
    var x = await _db.getWeightForChar(limit);
    var y = List.from(x.reversed);

    List list = [];
    for (var i = 0; i < y.length; i++) {
      var day = y[i].toMap()['day'];
      var month = Date.getShortMonthName(y[i].toMap()['month']);
      list.add('$day $month');
    }
    return list;
  }

  Future<List> getMonthForChart(limit) async {
    var x = await _db.getWeightForChar(limit);
    var y = List.from(x.reversed);

    List list = [];
    for (var i = 0; i < y.length; i++) {
      var month = Date.getShortMonthName(y[i].toMap()['month']);
      list.add('$month');
    }
    return list;
  }

  Future<int> numberOfRecords() async {
    int x = await _db.getNumberOfRows();
    return x;
  }



  Future<double> getMinimumWeightFromLimit(int limit) async {
    var x = await _db.getMinWeightFromLimit(limit);
    return x;
  }
  Future<double> getMaximummWeightFromLimit(int limit) async {
    var x = await _db.getMaxWeightFromLimit(limit);
    return x;
  }

  Future checkIfRecordWithDateExist(String date) async {
    var x = await _db.checkIfRecordExist(date);
    return x;
  }



}