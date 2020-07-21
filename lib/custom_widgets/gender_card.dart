import 'package:flutter/material.dart';
import 'package:weight_tracker_app/size_config.dart';



class GenderCard extends StatelessWidget {

  GenderCard({@required this.color, @required this.icon, @required this.text, @required this.onTap});

  final Color color;
  final IconData icon;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.heightMultiplier * 21,
        width: SizeConfig.widthMultiplier * 42,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              color: Color(0xFF8A8A98),
              size: SizeConfig.textMultiplier * 10,
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.textMultiplier * 2.5,
                color: Color(0xFF8A8A98),
              ),
            ),
          ],
        ),
      ),
    );
  }
}