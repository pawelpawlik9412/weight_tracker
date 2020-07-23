import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker_app/custom_widgets/bmi_card.dart';
import 'package:weight_tracker_app/custom_widgets/card_for_no_data.dart';
import 'package:weight_tracker_app/custom_widgets/range_button.dart';
import 'package:weight_tracker_app/custom_widgets/weight_card_list_view.dart';
import 'package:weight_tracker_app/screens/settings_screen.dart';
import 'package:weight_tracker_app/size_config.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:weight_tracker_app/custom_widgets/weight_text.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/providers/weight_data.dart';
import 'package:weight_tracker_app/bmi_calculator.dart';
import 'package:weight_tracker_app/date.dart';
import 'package:weight_tracker_app/custom_widgets/weight_chart.dart';
import 'package:weight_tracker_app/screens/weight_history_screen.dart';
import 'package:weight_tracker_app/screens/new_weight_screen.dart';
import 'package:weight_tracker_app/providers/preferences_data.dart';
import 'package:weight_tracker_app/custom_widgets/custom_floating_action_button.dart';
import 'package:weight_tracker_app/custom_widgets/first_weight_card.dart';

class WeightScreen extends StatelessWidget {
  final limit = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF16172E),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF16172E),
          body: Container(
            padding: EdgeInsets.only(
                right: SizeConfig.widthMultiplier * 3,
                top: SizeConfig.heightMultiplier,
                left: SizeConfig.widthMultiplier * 3),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FutureBuilder(
                          future: Provider.of<PreferencesData>(context)
                              .getAllPreferences(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SettingsScreen(
                                          targetWeight:
                                              snapshot.data['target weight'],
                                          gender: snapshot.data['gender'],
                                          height: snapshot.data['height'],
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.menu,
                                  size: SizeConfig.heightMultiplier * 3,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return IconButton(
                                onPressed: () {
                                  // TODO co jeśli nie ma danych.
                                },
                                icon: Icon(
                                  Icons.menu,
                                  size: SizeConfig.heightMultiplier * 3,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        ),
                        RangeButton()
//                        FlatButton(
//                          shape: RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(5.0),
//                            side: BorderSide(
//                              color: Color(0xFF313246),
//                              width: SizeConfig.widthMultiplier * 0.5,
//                            ),
//                          ),
//                          child: Text(
//                            'Last week \u2713',
//                            style: TextStyle(
//                              fontSize: SizeConfig.textMultiplier * 2.3,
//                              color: Color(0xFFBEC0CA),
//                            ),
//                          ),
//                          onPressed: () {
//                            //TODO dodaj zmiane zakresu daty.
//                          },
//                        ),
                      ],
                    ),
                  ),
                  WeightChart(),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  FutureBuilder(
                    future: Provider.of<WeightData>(context)
                        .getDataForWeightProgress(context),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: SizeConfig.heightMultiplier * 10.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  WeightText(
                                      weightLabel:
                                          snapshot.data['maxWeight'].toString(),
                                      weightLabelSize:
                                          SizeConfig.textMultiplier * 3.2,
                                      kiloTextSize:
                                          SizeConfig.textMultiplier * 2,
                                      textColor: Color(0xFF8A8A98)),
                                  WeightText(
                                      weightLabel: snapshot
                                          .data['currentWeight']
                                          .toString(),
                                      weightLabelSize:
                                          SizeConfig.textMultiplier * 5.5,
                                      kiloTextSize:
                                          SizeConfig.textMultiplier * 2.5,
                                      textColor: Colors.white),
                                  WeightText(
                                      weightLabel: snapshot.data['targetWeight']
                                          .toString(),
                                      weightLabelSize:
                                          SizeConfig.textMultiplier * 3.2,
                                      kiloTextSize:
                                          SizeConfig.textMultiplier * 2,
                                      textColor: Color(0xFF8A8A98)),
                                ],
                              ),
                              LinearPercentIndicator(
                                padding: EdgeInsets.symmetric(horizontal: 0.0),
                                lineHeight: SizeConfig.heightMultiplier * 0.4,
                                backgroundColor: Color(0xFF8A8A98),
                                progressColor: Color(0xFF61DCC9),
                                percent: snapshot.data['progress'],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          height: SizeConfig.heightMultiplier * 10.0,
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'BMI Calculator',
                          style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 3.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8A8A98),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier,
                        ),
                        FutureBuilder(
                          future: BmiCalculator.getBmiDetail(context),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return BmiCard(
                                bmi: snapshot.data['bmi'],
                                description: snapshot.data['description'],
                                color: snapshot.data['color'],
                                chart: snapshot.data['chart'],
                              );
                            } else {
                              return Container(
                                height: SizeConfig.heightMultiplier * 18.5,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF202037),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: CardForNoData(
                                    label:
                                        'There is no data here, input your weight\n to see a bmi.'),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                'History',
                                style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 3.5,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8A8A98),
                                ),
                              ),
                              FlatButton(
                                child: Text(
                                  'See All',
                                  style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF61DCC9),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return WeightHistoryScreen();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF202037),
                                Color(0xFF202037).withOpacity(0.0)
                              ],
                            ).createShader(
                                Rect.fromLTRB(50, 50, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: FutureBuilder(
                              future: Provider.of<WeightData>(context)
                                  .getHistoryDataWeight(limit),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  var list = snapshot.data['historyDataWeight'];
                                  var num = snapshot.data['numberOfRows'];
                                  if (num <= limit) {
                                    return Container(
                                      height:
                                          SizeConfig.heightMultiplier * 26.0,
                                      child: ListView.builder(
                                          itemCount: list.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            if (index < list.length - 1) {
                                              return WeightCardListView(
                                                date: Date.checkDate(
                                                    list[index]['fullDate']),
                                                weight: list[index]['weight']
                                                    .toString(),
                                                difference: list[index]
                                                    ['difference'],
                                              );
                                            } else {
                                              return FirstWeightCard(
                                                fullDate: Date.checkDate(
                                                    list[index]['fullDate']),
                                                weight: list[index]['weight']
                                                    .toString(),
                                              );
                                            }
                                          }),
                                    );
                                  } else {
                                    return Container(
                                      height:
                                          SizeConfig.heightMultiplier * 26.0,
                                      child: ListView.builder(
                                          itemCount: list.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return WeightCardListView(
                                              date: Date.checkDate(
                                                  list[index]['fullDate']),
                                              weight: list[index]['weight']
                                                  .toString(),
                                              difference: list[index]
                                                  ['difference'],
                                            );
                                          }),
                                    );
                                  }
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FutureBuilder(
              future: Provider.of<WeightData>(context, listen: false)
                  .checkIfRecordWithDateExist(
                      Date.getFormatDate(DateTime.now())),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == true) {
                    return CustomFloatingActionButton(
                        buttonLabel: 'NEW WEIGHT',
                        buttonColor: Colors.grey.withOpacity(0.5),
                        onPressed: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                    title: Text('Alert'),
                                    content: Container(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.heightMultiplier),
                                      child: Text(
                                          "You've already entered your weight today."),
                                    ),
                                    actions: <Widget>[
                                      CupertinoButton(
                                        child: Text('OK'),
                                        onPressed: Navigator.of(context).pop,
                                      )
                                    ],
                                  ));
                        });
                  } else {
                    return CustomFloatingActionButton(
                      buttonLabel: 'NEW WEIGHT',
                      buttonColor: Color(0xFF61DCC9),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NewWeightScreen();
                            },
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return Container();
                }
              }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
