import 'package:flutter/material.dart';
import 'package:weight_tracker_app/size_config.dart';
import 'package:string_validator/string_validator.dart';


class WeightInput extends StatefulWidget {

  WeightInput({@required this.formKey});

  final GlobalKey formKey;



  @override
  _WeightInputState createState() => _WeightInputState();
}

class _WeightInputState extends State<WeightInput> {




  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
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
          if (!isNumeric(value) || !isFloat(value)) {
            return 'Wrong, weight format';
          }
          return null;
        },
      ),
    );
  }
}