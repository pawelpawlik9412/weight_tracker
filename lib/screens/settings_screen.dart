import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/custom_widgets/custom_floating_action_button.dart';
import 'package:weight_tracker_app/providers/preferences_data.dart';
import 'package:weight_tracker_app/screens/weight_screen.dart';
import 'package:weight_tracker_app/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:string_validator/string_validator.dart';
import 'package:weight_tracker_app/custom_widgets/gender_card.dart';
import 'package:weight_tracker_app/custom_widgets/slider_card.dart';
import 'package:weight_tracker_app/types.dart';
import 'package:flutter/cupertino.dart';




class SettingsScreen extends StatefulWidget {

  SettingsScreen({
    @required this.targetWeight,
    @required this.height,
    @required this.gender,
  });

  final String targetWeight;
  final int height;
  final Gender gender;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  Gender selectedGender;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  SliderCard sliderCard;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedGender = widget.gender;
    _controller.text = widget.targetWeight;
    sliderCard = SliderCard(height: widget.height);
  }


  bool checkSettings(BuildContext context) {
    if (_formKey.currentState.validate() && selectedGender != null && sliderCard.getHeight() != 0) {
      Provider.of<PreferencesData>(context, listen: false).safeWeightTargetPreferences(_controller.text);
      Provider.of<PreferencesData>(context, listen: false).safeGenderPreferences(selectedGender);
      Provider.of<PreferencesData>(context, listen: false).safeHeightPreferences(sliderCard.getHeight().toString());
      return true;
    } else {
      print('Uzupełnij dane');
      return false;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF16172E),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Color(0xFF16172E),
            elevation: 0.0,
          ),
          body: Container(
            padding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier * 6,
              right: SizeConfig.widthMultiplier * 6,
              top: SizeConfig.heightMultiplier * 10,
              bottom: SizeConfig.heightMultiplier * 4,
            ),
            color: Color(0xFF16172E),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'SET TARGET WEIGHT',
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 3.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8A8A98),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _controller,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(
                            color: Color(0xFF8A8A98),
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.redAccent),
                          filled: true,
                          fillColor: Color(0xFF202037),
                          hintText: 'Type your target weight',
                          hintStyle: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            color: Color(0xFF8A8A98),
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if(!isFloat(value)) {
                            return 'Wrong, weight format';
                          }
                          else if (value == '' || value == null) {
                            return 'Missing target weight';
                          }
                          else if(double.parse(value) <= 0 || value.substring(value.length - 1) == '.' || value[0] == '.') {
                            return 'Wrong, weight format';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'SELECT YOUR GENDER',
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 3.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8A8A98),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GenderCard(
                          color: selectedGender == Gender.male ? Color(0xFF202037) : Color(0xFF16172E),
                          icon: FontAwesomeIcons.mars,
                          text: 'MALE',
                          onTap: () {
                            setState(() {
                              selectedGender = Gender.male;
                            });
                          },
                        ),
                        GenderCard(
                          color: selectedGender == Gender.female ? Color(0xFF202037) : Color(0xFF16172E),
                          icon: FontAwesomeIcons.venus,
                          text: 'FEMALE',
                          onTap: () {
                            setState(() {
                              selectedGender = Gender.female;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'SET YOUR HEIGHT',
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 3.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8A8A98),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier,
                    ),
                    sliderCard,
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
              ],
            ),
          ),
          floatingActionButton: CustomFloatingActionButton(
            buttonLabel: 'SAVE SETTINGS',
            buttonColor: Color(0xFF61DCC9),
            onPressed: () {
              checkSettings(context) ?
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WeightScreen();
                  },
                ),
              ) : showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: Text('Alert'),
                    content: Container(
                      padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
                      child: Text("Some data is missing or data format is wrong"),
                    ),
                    actions: <Widget>[
                      CupertinoButton(
                        child: Text('OK'),
                        onPressed: Navigator.of(context).pop,
                      )
                    ],
                  ));
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
