import 'package:flutter/material.dart';
import 'package:weight_tracker_app/size_config.dart';

class FirstWeightCard extends StatelessWidget {

  FirstWeightCard({@required this.fullDate, @required this.weight});

  String fullDate;
  String weight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 0.8),
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 5.0,
          vertical: SizeConfig.heightMultiplier * 1.2),
      height: SizeConfig.heightMultiplier * 9.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF202037),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            fullDate,
            style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 1.8,
              color: Color(0xFF8A8A98),
            ),
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
