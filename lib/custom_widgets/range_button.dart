import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/size_config.dart';
import 'package:weight_tracker_app/providers/preferences_data.dart';

class RangeButton extends StatefulWidget {
  @override
  _RangeButtonState createState() => _RangeButtonState();
}

class _RangeButtonState extends State<RangeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 4.5,
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Color(0xFF202037),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: FutureBuilder(
        future:
            Provider.of<PreferencesData>(context).getTextForTimeRangeButton(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return DropdownButton<String>(
              dropdownColor: Color(0xFF202037),
              value: snapshot.data,
              icon: Icon(Icons.arrow_downward, color: Colors.white),
              iconSize: SizeConfig.textMultiplier * 3,
              elevation: 0,
              style: TextStyle(
                  color: Color(0xFFBEC0CA),
                  fontSize: SizeConfig.textMultiplier * 2),
              underline: Container(),
              onChanged: (String newValue) {
                setState(() {
                  Provider.of<PreferencesData>(context, listen: false)
                      .safeTimeRangePreferences(newValue);
                });
              },
              items: <String>['Last week', 'Last month', 'Last 6 month', 'Last year']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  onTap: () {
                    Provider.of<PreferencesData>(context, listen: false)
                        .safeTimeRangePreferences(value);
                  },
                  child: Text(
                    value,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.textMultiplier * 2),
                  ),
                );
              }).toList(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
