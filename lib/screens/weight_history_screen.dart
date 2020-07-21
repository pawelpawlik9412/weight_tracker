import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/custom_widgets/first_weight_card.dart';
import 'package:weight_tracker_app/size_config.dart';
import 'package:weight_tracker_app/custom_widgets/weight_card_list_view.dart';
import 'package:weight_tracker_app/providers/weight_data.dart';
import 'package:weight_tracker_app/date.dart';

class WeightHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF16172E),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF16172E),
            elevation: 0.0,
            title: Text(
              'Weight History',
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2.5,
                color: Colors.white,
                fontWeight: FontWeight.w600,
//            color: Color(0xFF8A8A98),
              ),
            ),
          ),
          body: Container(
            color: Color(0xFF16172E),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 2),
              child: FutureBuilder(
                  future: Provider.of<WeightData>(context).getAllHistoryDataWeight(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData) {
                      var list = snapshot.data;
                      return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, index) {
                            if (index < list.length - 1) {
                              return WeightCardListView(
                                date: Date.checkDate(list[index]['fullDate']),
                                weight: list[index]['weight'].toString(),
                                difference: list[index]['difference'],
                              );
                            } else {
                              return FirstWeightCard(
                                fullDate: Date.checkDate(list[index]['fullDate']),
                                weight: list[index]['weight'].toString(),
                              );
                            }
                          }
                      );
                    }
                    else {
                      return Center(
                          child: CircularProgressIndicator()
                      );
                    }
                  }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
