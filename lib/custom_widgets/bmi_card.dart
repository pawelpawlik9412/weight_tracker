import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:weight_tracker_app/size_config.dart';

class BmiCard extends StatelessWidget {

  BmiCard({
    @required this.bmi,
    @required this.description,
    @required this.color,
    @required this.chart,
  });

  final String bmi;
  final String description;
  final Color color;
  final int chart;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 18.5,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF202037),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  bmi,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.textMultiplier * 4.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.textMultiplier,
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Color(0xFF61DCC9),
                    fontSize: SizeConfig.textMultiplier * 1.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            StepProgressIndicator(
              totalSteps: 53,
              size: SizeConfig.heightMultiplier * 3.9,
              selectedColor: color,
              currentStep: chart,
            )
          ],
        ),
      ),
    );
  }
}