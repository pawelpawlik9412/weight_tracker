import 'package:weight_tracker_app/model/weight.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class DatabaseHelper {

  String id = 'id';
  String weightTable = 'weight_table';
  String fullDate = 'fullDate';
  String day = 'day';
  String month = 'month';
  String year = 'year';
  String weight = 'weight';
  String difference = 'difference';

  static Database _database;
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();


  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  get _dbPath async {
    String documentsDirectory = await _localPath;
    return documentsDirectory + "$weightTable.db";
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<bool> dbExists() async {
    return File(await _dbPath).exists();
  }

  initDB() async {
    String path = await _dbPath;
//    print(path);
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $weightTable ("
          "$id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$fullDate TEXT,"
          "$day INTEGER,"
          "$month INTEGER,"
          "$year INTEGER,"
          "$weight REAL"
          ")");
    });
  }

  closeDB() {
    if (_database != null) {
      _database.close();
    }
  }

  // CRUD OPERATIONS FOR DATABASE //

  Future<int> insertWeigh(Weight weight) async {
    var db = await this.database;
    var result = await db.insert(weightTable, weight.toMap());
    return result;
  }
  
  Future getLastWeightFromDatabase() async {
    var db = await this.database;
    var x = await db.rawQuery('SELECT $weight FROM $weightTable WHERE $id = (SELECT MAX($id) FROM $weightTable)');
    var result;
    try {
      result = x[0][weight];
    }
    catch (e) {
      result = null;
      print(e);
    }
    return result;
  }

  Future getMaxWeightFromDatabase() async {
    var db = await this.database;
    var x = await db.rawQuery('SELECT $weight FROM $weightTable WHERE $weight = (SELECT MAX($weight) FROM $weightTable)');
    var result;
    try {
      result = x[0][weight];
    }
    catch (e) {
      result = null;
      print(e);
    }
    return result;
  }

  Future<int> getNumberOfRows() async {
    var db = await this.database;
    var numberOfRecords = await db.rawQuery('SELECT count (*) FROM $weightTable');
    var x = numberOfRecords[0].values.toString();
    var result = int.parse(x.substring(1, x.length - 1));
    return result;
  }

  Future getWeightDataHistory(int limit) async {
    var db = await this.database;
    var newLimit = limit + 1;
    var firstData = await db.rawQuery('SELECT $weight, $fullDate FROM $weightTable ORDER BY $fullDate DESC LIMIT $limit');
    var secondData = await db.rawQuery('SELECT $weight FROM $weightTable ORDER BY $fullDate DESC LIMIT $newLimit');
    var result = [];

    if(await getNumberOfRows() <= limit) {
      for (var i = 0; i < firstData.length; i++) {
        try {
          double x = firstData[i][weight] * 10;
          double y = secondData[i + 1][weight] * 10;
          Map map = {};
          map[weight] = x / 10;
          map[fullDate] = firstData[i][fullDate];
          map[difference] = (x - y) / 10;
          result.add(map);
        }
        catch (e) {
          print(e);
        }
      }
      var firstWeight = await getFirstWeightFromDatabase();
      Map map = {};
      map[fullDate] = firstWeight[fullDate];
      map[weight] =firstWeight[weight];
      result.add(map);
    }
    else {
      for (var i = 0; i < firstData.length; i++) {
        try {
          double x = firstData[i][weight] * 10;
          double y = secondData[i + 1][weight] * 10;
          Map map = {};
          map[weight] = x / 10;
          map[fullDate] = firstData[i][fullDate];
          map[difference] = (x - y) / 10;
          result.add(map);
        }
        catch (e) {
          print(e);
        }
      }
    }
    return result;
  }

  Future getAllWeightDataHistory() async {
    var db = await this.database;
    var firstData = await db.rawQuery('SELECT $weight, $fullDate FROM $weightTable ORDER BY $fullDate DESC');
    var secondData = await db.rawQuery('SELECT $weight FROM $weightTable ORDER BY $fullDate DESC');
    var result = [];
    for (var i = 0; i < firstData.length; i++) {
      try {
        double x = firstData[i][weight] * 10;
        double y = secondData[i + 1][weight] * 10;
        Map map = {};
        map[weight] = x / 10;
        map[fullDate] = firstData[i][fullDate];
        map[difference] = (x - y) / 10;
        result.add(map);
      }
      catch (e) {
        print(e);
      }
    }
    var firstWeight = await getFirstWeightFromDatabase();
    Map map = {};
    map[fullDate] = firstWeight[fullDate];
    map[weight] =firstWeight[weight];
    result.add(map);
    return result;
  }




  Future<List<Weight>> getWeightForChar(int limit) async {
    var db = await this.database;
    var map = await db.query('$weightTable order by $fullDate DESC limit $limit');
    List<Weight> weightList = [];

    for (int i = 0; i < map.length; i++) {
      weightList.add(Weight.fromMapObject(map[i]),
      );
    }

    return weightList;
  }

  Future getMinWeightFromLimit(int limit) async {
    var db = await this.database;
    var result = await db.rawQuery('SELECT min($weight) FROM (SELECT $weight FROM $weightTable ORDER BY $fullDate DESC LIMIT $limit)');
    return result[0]['min(weight)'];
  }

  Future getMaxWeightFromLimit(int limit) async {
    var db = await this.database;
    var result = await db.rawQuery('SELECT max($weight) FROM (SELECT $weight FROM $weightTable ORDER BY $fullDate DESC LIMIT $limit)');
    return result[0]['max(weight)'];
  }
  
  Future<bool> checkIfRecordExist(String date) async {
    var db = await this.database;
    var x = await db.rawQuery('SELECT EXISTS(SELECT 1 FROM $weightTable WHERE $fullDate="$date")');
    if (x[0]['EXISTS(SELECT 1 FROM weight_table WHERE fullDate="$date")'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future getDataForChartLongTimeRange(int limit) async {
    List monthList = [];
    List yearList = [];
    var db = await this.database;
    var result = await db.rawQuery('SELECT $fullDate, $weight FROM $weightTable LIMIT $limit');


    for(var x in result) {
      var str = x[fullDate];
      if(!monthList.contains(str.substring(5, 7))) {
        monthList.add(str.substring(5, 7));
      }
      if(!yearList.contains(str.substring(0, 4))) {
        yearList.add(str.substring(0, 4));
      }
    }
    Map map = {};


    for(var x in yearList) {
      for(var i in monthList) {
        var sum = 0.0;
        var len = 0;
        for(var z in result) {
          if(z[fullDate].substring(5, 7) == i && z[fullDate].substring(0, 4) == x) {
            sum = sum + z[weight];
            len ++;
          }
        }
        if(sum != 0) {
          var mediana = sum / len;
          map['$x-$i'] = double.parse((mediana).toStringAsFixed(1));
        }
      }
    }

    return map;
  }


  Future getFirstWeightFromDatabase() async {
    var db = await this.database;
    var result = await db.rawQuery('SELECT $weight, $fullDate FROM $weightTable WHERE $id = (SELECT MIN($id) FROM $weightTable)');
    return result[0];
  }
}