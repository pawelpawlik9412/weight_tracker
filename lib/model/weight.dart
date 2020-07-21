class Weight {

  int id;
  String fullDate;
  int day;
  int month;
  int year;
  double weight;


  Weight(
      {this.id, this.fullDate, this.day, this.month, this.year, this.weight});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['fullDate'] = fullDate;
    map['day'] = day;
    map['month'] = month;
    map['year'] = year;
    map['weight'] = weight;
    return map;
  }

  Weight.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.fullDate = map['fullDate'];
    this.day = map['day'];
    this.month = map['month'];
    this.year = map['year'];
    this.weight = map['weight'];
  }
}