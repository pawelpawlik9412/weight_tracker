import 'package:flutter/material.dart';
import 'package:weight_tracker_app/size_config.dart';

class CardForNoData extends StatelessWidget {

  CardForNoData({@required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF8A8A98),
            fontSize: SizeConfig.textMultiplier * 1.8,
          ),
        ),
      ),
    );
  }
}
