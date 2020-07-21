import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weight_tracker_app/custom_widgets/card_for_no_data.dart';
import 'package:weight_tracker_app/size_config.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/providers/weight_data.dart';

class WeightChart extends StatefulWidget {
  @override
  _WeightChartState createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 2 / 0.85,
          child: Container(
            padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 4,
                right: SizeConfig.widthMultiplier * 4),
            child: FutureBuilder(
                future: Provider.of<WeightData>(context, listen: false)
                    .getWeightDetailForChart(7),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return LineChart(
                      mainData(snapshot.data),
                    );
                  } else {
                    return CardForNoData(label: 'There is no data here, input your weight\n to see a chart.',);
                  }
                }),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(Map data) {
    return LineChartData(
      axisTitleData: FlAxisTitleData(
        show: false,
      ),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: false,
        drawVerticalLine: false,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 0.5,
            tooltipBgColor: Color(0xFF202037),
          )),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.textMultiplier * 1.8,
          ),
          getTitles: (value) {
            if ((value.toDouble()) == data['max weight']) {
              return '${data['max weight']} kg';
            }
            if ((value.toDouble() + 0.1) == data['max weight']) {
              return '${data['max weight']} kg';
            }
            if ((value.toDouble() + 0.2) == data['max weight']) {
              return '${data['max weight']} kg';
            }
            if ((value.toDouble() + 0.3) == data['max weight']) {
              return '${data['max weight']} kg';
            }
            if ((value.toDouble() + 0.4) == data['max weight']) {
              return '${data['max weight']} kg';
            }
            if ((value.toDouble() + 0.5) == data['max weight']) {
              return '${data['max weight']} kg';
            }
            if ((value.toDouble() + 0.6) == data['max weight']) {
              return '${data['max weight']} kg';
            }
            if ((value.toDouble() + 0.7) == data['max weight']) {
              return '${data['max weight']} kg';
            }
            if ((value.toDouble() + 0.8) == data['max weight']) {
              return '${data['max weight']} kg';
            }
            if ((value.toDouble() + 0.9) == data['max weight']) {
              return '${data['max weight']} kg';
            }
            if (value.toDouble() == data['min weight']) {
              return '${data['min weight']} kg';
            }
            if ((value.toDouble() + 0.1) == data['min weight']) {
              return '${data['min weight']} kg';
            }
            if ((value.toDouble() + 0.2) == data['min weight']) {
              return '${data['min weight']} kg';
            }
            if ((value.toDouble() + 0.3) == data['min weight']) {
              return '${data['min weight']} kg';
            }
            if ((value.toDouble() + 0.4) == data['min weight']) {
              return '${data['min weight']} kg';
            }
            if ((value.toDouble() + 0.5) == data['min weight']) {
              return '${data['min weight']} kg';
            }
            if ((value.toDouble() + 0.6) == data['min weight']) {
              return '${data['min weight']} kg';
            }
            if ((value.toDouble() + 0.7) == data['min weight']) {
              return '${data['min weight']} kg';
            }
            if ((value.toDouble() + 0.8) == data['min weight']) {
              return '${data['min weight']} kg';
            }
            if ((value.toDouble() + 0.9) == data['min weight']) {
              return '${data['min weight']} kg';
            } else {
              return '';
            }
          },
          reservedSize: SizeConfig.widthMultiplier * 14,
          margin: SizeConfig.widthMultiplier * 4,
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: SizeConfig.heightMultiplier * 2.2,
          textStyle: TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.textMultiplier * 1.8),
          getTitles: (value) {
            if (value.toInt() == 0) {
              return '${data['dates'][0]}';
            }
            if (value.toInt() == 2) {
              return '${data['dates'][2]}';
            }
            if (value.toInt() == 4) {
              return '${data['dates'][4]}';
            }
            if (value.toInt() == 6) {
              return '${data['dates'][6]}';
            }
            else {
              return '';
            }
          },
          margin: SizeConfig.heightMultiplier,
        ),
      ),
      minX: 0,
      maxX: data['fl spots'].length.toDouble() - 1,
      minY: data['min weight'] - 5,
      maxY: data['max weight'],
      lineBarsData: [
        LineChartBarData(
          spots: data['fl spots'],
          isCurved: true,
          colors: gradientColors,
          barWidth: SizeConfig.widthMultiplier * 0.8,
          isStrokeCapRound: true,
          dotData: FlDotData(
              show: true,
              strokeWidth: 3.5,
              getStrokeColor: (spot, doub, lineChar) {
                spot = data['last fl spot'];
                doub = 0.5;
                return Color(0xFF61DCC9);
              },
              getDotColor: (spot, doub, lineChar) {
                spot = data['last fl spot'];
                doub = 0.2;
                return Color(0xFF16172E);
              },
              dotSize: 5.0,
              checkToShowDot: (spot, lineChart) {
                bool check;
                if (spot == data['last fl spot']) {
                  check = true;
                  return check;
                } else {
                  check = false;
                  return check;
                }
              }),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
