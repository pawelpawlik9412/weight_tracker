import 'package:flutter/material.dart';
import 'package:weight_tracker_app/size_config.dart';


class CustomFloatingActionButton extends StatelessWidget {

  CustomFloatingActionButton({@required this.buttonLabel, @required this.buttonColor, @required this.onPressed});

  final String buttonLabel;
  final Color buttonColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: buttonColor,
      label: Container(
        width: SizeConfig.widthMultiplier * 40,
        child: Center(
          child: Text(
            buttonLabel,
            style: TextStyle(
              color: Color(0xFF202037),
              fontSize: SizeConfig.textMultiplier * 1.8,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}