import 'package:flutter/cupertino.dart';
import 'package:weight_tracker_app/model/shared_pref.dart';
import 'package:weight_tracker_app/types.dart';


class PreferencesData extends ChangeNotifier {

  static final _genderPref = SharedPref(instanceName: 'gender', deflautValue: null);
  static final _targetWeightPref = SharedPref(instanceName: 'targetWeight', deflautValue: null);
  static final _heightPref = SharedPref(instanceName: 'height', deflautValue: null);
  static final _selectedTimeRange = SharedPref(instanceName: 'timeRange', deflautValue: '7');

  // Methods for timeRange preferences

  Future<String> getTimeRangePreferences() async{
    var x = await _selectedTimeRange.read();
    return x;
  }

  void safeTimeRangePreferences(String timeRange) {
    if(timeRange == 'Last week') {
      _selectedTimeRange.save('7');
    }
    else if(timeRange == 'Last month') {
      _selectedTimeRange.save('30');
    }
    else if(timeRange == 'Last 6 month') {
      _selectedTimeRange.save('183');
    }
    else {
      _selectedTimeRange.save('365');
    }
    notifyListeners();
  }

  void removeTimeRangePreferences() {
    _selectedTimeRange.remove();
    notifyListeners();
  }


  // Methods for gender preferences.
  Future<String> getGenderPreferences() async {
    var x = await _genderPref.read();
    return x;
  }
  void safeGenderPreferences(Gender value) {
    if(value == Gender.male) {
      _genderPref.save('male');
    } else {
      _genderPref.save('female');
    }
    notifyListeners();
  }

  Future<String> getTextForTimeRangeButton() async {
    var x = await getTimeRangePreferences();
    if(x == '7') {
      return 'Last week';
    }
    else if(x == '30') {
      return 'Last month';
    }
    else if(x == '183') {
      return 'Last 6 month';
    }
    else {
      return 'Last year';
    }
  }


  void removeGenderPreferences() {
    _genderPref.remove();
    notifyListeners();
  }


  // Methods for target weight preferences.
  Future<String> getWeightTargetPreferences() async {
    var x = await _targetWeightPref.read();
    return x;
  }
  void safeWeightTargetPreferences(String value) {
    _targetWeightPref.save(value);
    notifyListeners();
  }
  void removeWeightTargetPreferences() {
    _targetWeightPref.remove();
    notifyListeners();
  }



  // Methods for height preferences.
  Future<String> getHeightPreferences() async {
    var x = await _heightPref.read();
    return x;
  }
  void safeHeightPreferences(String value) {
    _heightPref.save(value);
    notifyListeners();
  }
  void removeHeightPreferences() {
    _heightPref.remove();
    notifyListeners();
  }



  // Methods for checking preferences in SettingsScreen()
  Future<bool> checkAllPreferences() async {
    var weight = await getWeightTargetPreferences();
    var gender = await getGenderPreferences();
    var height = await getHeightPreferences();

    if(weight == null && gender == null && height == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<Map> getAllPreferences() async {
    var weight = await getWeightTargetPreferences();
    var height = await getHeightPreferences();
    var gender;

    if(await getGenderPreferences() == 'male') {
      gender = Gender.male;
    } else {
      gender = Gender.female;
    }
    Map map = {};
    map['target weight'] = weight;
    map['gender'] = gender;
    map['height'] = int.parse(height);
    return map;
  }
}