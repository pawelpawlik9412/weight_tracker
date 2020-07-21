import 'package:flutter/material.dart';

class WeightText extends StatelessWidget {
  WeightText(
      {@required this.weightLabel,
        @required this.weightLabelSize,
        @required this.kiloTextSize,
        @required this.textColor});

  String weightLabel;
  double weightLabelSize;
  double kiloTextSize;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: <Widget>[
        Text(
          weightLabel,
          style: TextStyle(
            color: textColor,
            fontSize: weightLabelSize,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          'kg',
          style: TextStyle(
            color: textColor,
            fontSize: kiloTextSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
