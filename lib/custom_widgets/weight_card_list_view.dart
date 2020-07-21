import 'package:flutter/material.dart';
import 'package:weight_tracker_app/size_config.dart';

class WeightCardListView extends StatelessWidget {

  WeightCardListView({
    @required this.date,
    @required this.difference,
    @required this.weight
  });

  final String date;
  final double difference;
  final String weight;


  Map setColorAndIcon(double difference) {
    Map map = {};
    if(difference < 0) {
      map['color'] = Color(0xFF61DCC9);
      map['icon'] = Icons.arrow_downward;
    }
    else if(difference > 0) {
      map['color'] = Colors.redAccent;
      map['icon'] = Icons.arrow_upward;
    }
    else {
      map['color'] = Colors.white;
      map['icon'] = Icons.remove;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 0.8),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5.0, vertical: SizeConfig.heightMultiplier * 1.2),
      height: SizeConfig.heightMultiplier * 9.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF202037),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                date,
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 1.8,
                  color: Color(0xFF8A8A98),
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    setColorAndIcon(difference)['icon'],
                    color: setColorAndIcon(difference)['color'],
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier,
                  ),
                  Text(
                    difference.toString(),
                    style: TextStyle(
                      color: setColorAndIcon(difference)['color'],
                      fontSize: SizeConfig.textMultiplier * 2.1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                weight,
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 3.5,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier,
              ),
              Text(
                'kg',
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier *1.8,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
