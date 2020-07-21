import 'package:flutter/material.dart';
import 'package:weight_tracker_app/size_config.dart';


class SliderCard extends StatefulWidget {

  SliderCard({@required this.height});

  int height;

  int getHeight() {
    return height;
  }


  @override
  _SliderCardState createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {

  double defaultHeigt = 110.0;

  bool checkHeight() {
    if(widget.height == null) {
      return false;
    } else {
      return true;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeConfig.heightMultiplier * 20,
      decoration: BoxDecoration(
        color: Color(0xFF202037),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              inactiveTrackColor: Color(0xFF8A8A98),
              activeTrackColor: Color(0xFF61DCC9),
              thumbColor: Color(0xFF61DCC9),
              overlayColor: Color(0xFF61DCC9).withOpacity(0.1),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 25.0),
            ),
            child: Slider(
              value: checkHeight() ? widget.height.toDouble() : defaultHeigt,
              min: 0.0,
              max: 220.0,
              onChanged: (double newValue) {
                setState(() {
                  widget.height = newValue.round();
                });
              },
            ),
          ),
          Text(
            checkHeight() ? '${widget.height.toString()} m' : '${defaultHeigt.toString()}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.textMultiplier * 3.5,
              color: Color(0xFF8A8A98),
            ),
          ),
        ],
      ),
    );
  }
}
