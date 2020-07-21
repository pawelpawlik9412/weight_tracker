import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/model/weight.dart';
import 'package:weight_tracker_app/providers/weight_data.dart';
import 'package:weight_tracker_app/size_config.dart';
import 'package:weight_tracker_app/date.dart';

class NewWeightScreen extends StatefulWidget {
  @override
  _NewWeightScreenState createState() => _NewWeightScreenState();
}

class _NewWeightScreenState extends State<NewWeightScreen> {
  var newWeightValue = 500.0;
  var newWeightLabel = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF16172E),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color(0xFF16172E),
            title: Text(
              'New Weight',
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2.5,
                color: Colors.white,
                fontWeight: FontWeight.w600,
//            color: Color(0xFF8A8A98),
              ),
            ),
          ),
          backgroundColor: Color(0xFF16172E),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.heightMultiplier * 10,
              ),
              Center(
                child: Container(
                  width: SizeConfig.widthMultiplier * 90,
                  height: SizeConfig.heightMultiplier * 45,
                  decoration: BoxDecoration(
                    color: Color(0xFF202037),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          Date.getFullDateForNewWeightCard(DateTime.now()),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.textMultiplier * 2.5,
                            color: Color(0xFF8A8A98),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: SizeConfig.widthMultiplier * 85,
                              child: CupertinoSlider(
                                onChanged: (value) {
                                  setState(() {
                                    var val = value.toInt();
                                    newWeightValue = val.toDouble();
                                    newWeightLabel = newWeightValue / 10;
                                  });
                                },
                                activeColor: Color(0xFF61DCC9),
                                value: newWeightValue,
                                max: 2000,
                                min: 0,
                              ),
                            ),
                            Text(
                              '${newWeightLabel.toString()}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.textMultiplier * 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Provider.of<WeightData>(context, listen: false).addWeight(
                Weight(
                  weight: newWeightLabel,
                  fullDate: Date.getFormatDate(DateTime.now()),
                  month: DateTime.now().month,
                  day: DateTime.now().day,
                  year: DateTime.now().year,
                ),
              );
              Navigator.pop(context);
            },
            backgroundColor: Color(0xFF61DCC9),
            label: Container(
              width: SizeConfig.widthMultiplier * 40,
              child: Center(
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    color: Color(0xFF202037),
                    fontSize: SizeConfig.textMultiplier * 1.8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
